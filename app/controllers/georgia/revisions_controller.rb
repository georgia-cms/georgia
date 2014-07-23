module Georgia
  class RevisionsController < ApplicationController

    before_filter :prepare_revision, except: :index
    before_filter :prepare_page, only: :index
    before_filter :prepare_content, only: [:edit, :update]

    def index
      @revisions = @page.revisions.order('created_at DESC')
      authorize @revisions
    end

    def show
      authorize @revision
      redirect_to [:edit, @page, @revision]
    end

    def edit
      authorize @revision
      locale = params.fetch(:locale, current_locale)
      @activities = (@page.activities + @revision.activities).uniq.sort_by(&:created_at).reverse
      @slides = @revision.slides.ordered.with_locale(locale)
      @ui_sections = Georgia::UiSection.all
      @status_message = RevisionStatusMessage.new(current_user, @page, @revision)
      @awaiting_revisions = @page.revisions.where(status: Georgia::Revision.statuses[:review])
      @draft_revision = @page.revisions.where.not(id: @revision.id).where(user: current_user).where(status: [Georgia::Revision.statuses[:review], Georgia::Revision.statuses[:draft]]).first
    end

    # Stores a copy of the current revision before updating
    def update
      authorize @revision
      update_with_service do |service|
        service_object = service.new(current_user, @page, @revision, sanitized_attributes)
        if service_object.call
          CreateActivity.new(@revision, :update, owner: current_user).call
          redirect_to [:edit, @page, service_object.revision], notice: "#{service_object.revision.title} was successfully updated."
        else
          redirect_to [:edit, @page, @revision], alert: service_object.revision.errors.full_messages.join('. ')
        end
      end
    end

    def destroy
      authorize @revision
      # FIXME: Check if this is the last revision for the page. Can't delete the last revision.
      if @revision.destroy
        redirect_to [:edit, @page], notice: "Revision was successfully deleted."
      else
        redirect_to page_revisions_path(@page), alert: "Oups! Something went wrong."
      end
    end

    # Sends revision to main_app router
    # FIXME: bypass this once Georgia will be loaded on root
    def preview
      authorize @page
      redirect_to preview_url
    end

    def draft
      authorize @revision
      ensure_remove_previous_drafts_of_the_same_page
      if @draft = Georgia::CloneRevision.create(@revision, status: 'draft', revised_by_id: current_user.id)
        CreateActivity.new(@draft, :draft, owner: current_user).call
        redirect_to [:edit, @page, @draft], notice: "You successfully created a new draft."
      else
        redirect_to [:edit, @page, @revision], alert: "Oups! Something went wrong."
      end
    end

    def request_review
      authorize @revision
      if @revision.update(status: :review)
        CreateActivity.new(@revision, :review, owner: current_user).call
        notify("#{current_user.name} is asking you to review #{@revision.title}.", edit_page_revision_path(@page, @revision, only_path: false))
        redirect_to [:edit, @page, @revision], notice: "You successfully submited #{@revision.title} for review."
      else
        redirect_to [:edit, @page, @revision], alert: "Oups! Something went wrong."
      end
    end

    def approve
      authorize @revision
      if @revision.update(status: :published)
        @page.current_revision.update(status: :revision)
        @page.update(revision_id: @revision.id)
        CreateActivity.new(@revision, :approve, owner: current_user).call
        redirect_to [:edit, @page, @revision], notice: "You have successfully approved and published #{@revision.title}."
      else
        redirect_to [:edit, @page, @revision], alert: "Oups! Something went wrong."
      end
    end

    def decline
      authorize @revision
      if @revision.update(status: :draft)
        CreateActivity.new(@page, :decline, owner: current_user).call
        message = "#{current_user.name} has successfully declined a review for #{@revision.title}."
        @revision.destroy
        redirect_to [:edit, @page], notice: message
      else
        redirect_to [:edit, @page, @revision], alert: "Oups! Something went wrong."
      end
    end

    def restore
      authorize @revision
      if @revision.update(status: :published)
        @page.current_revision.update(status: :revision)
        @page.update(revision_id: @revision.id)
        CreateActivity.new(@revision, :restore, owner: current_user).call
        redirect_to @page, notice: "#{current_user.name} has successfully restored a previous revision for #{@revision.title}."
      else
        redirect_to page_revisions_path(@page), alert: "Oups! Something went wrong."
      end
    end

    private

    def prepare_page
      polymorphic_resource_key = params.keys.select{|k| k.match('_id')}.first
      @page = Page.where(id: params[polymorphic_resource_key]).first
    end

    def prepare_revision
      @revision = Revision.where(id: params[:id]).first
      if @revision
        @page = @revision.try(:revisionable)
      else
        authorize Georgia::Revision
        prepare_page
        if @page
          redirect_to [:edit, @page], alert: 'This revision has been deleted or does not exist.'
        else
          redirect_to georgia.root_path, alert: "This resource has been deleted or does not exist."
        end
      end
    end

    def prepare_content
      if locale = params[:locale]
        @content = @revision.contents.select{|c| c.locale.to_s == locale}.first
        @content ||= Georgia::Content.new(locale: locale) if locale
      else
        @content = @revision.content
      end
      @content = Georgia::ContentDecorator.decorate(@content)
    end

    def notify(message, url)
      Notifier.notify_editors(message, url).deliver
    end

    def preview_url
      "#{@page.decorate.url}?r=#{@revision.id}"
    end

    def revision_params
      params.require(:revision).permit(:template, contents_attributes: [:text, :title, :locale, :excerpt, :keyword_list, :image_id, :id])
    end

    def sanitized_attributes
      attributes = revision_params
      attributes[:contents_attributes].each do |id, content_attributes|
        attributes[:contents_attributes][id] = ParseJsonTags.new(content_attributes, key: :keyword_list).call
      end
      attributes
    end

    def update_with_service
      service = 
        if policy(@revision).publish?
          UpdateRevision::Admin
        elsif policy(@revision).draft_changes?
          UpdateRevision::Contributor
        else
          UpdateRevision::Guest
        end
      yield service
    end

    def ensure_remove_previous_drafts_of_the_same_page
      @page.revisions.where(user: current_user).where(status: [Georgia::Revision.statuses[:review], Georgia::Revision.statuses[:draft]]).destroy_all
    end

  end
end