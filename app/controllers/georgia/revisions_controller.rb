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
    end

    # Stores a copy of the current revision before updating
    def update
      authorize @revision
      attributes = revision_params
      attributes[:contents_attributes].each do |id, content_attributes|
        attributes[:contents_attributes][id] = ParseJsonTags.new(content_attributes, key: :keyword_list).call
      end
      if UpdateRevision.new(self, @page, @revision, attributes).call
        CreateActivity.new(@revision, :update, owner: current_user).call
        redirect_to [:edit, @page, @revision], notice: "#{@revision.title} was successfully updated."
      else
        redirect_to [:edit, @page, @revision], alert: @revision.errors.full_messages.join('. ')
      end
    end

    def destroy
      authorize @revision
      if @revision.destroy
        redirect_to page_revisions_path(@page), notice: "#{@revision.title or 'Revision'} was successfully deleted."
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

    def review
      authorize @revision
      if @revision.review
        CreateActivity.new(@revision, :review, owner: current_user).call
        notify("#{current_user.name} is asking you to review #{@revision.title}.", edit_page_revision_path(@page, @revision, only_path: false))
        redirect_to [:edit, @page, @revision], notice: "You successfully submited #{@revision.title} for review."
      else
        redirect_to [:edit, @page, @revision], alert: "Oups! Something went wrong."
      end
    end

    def approve
      authorize @revision
      if @revision.approve
        CreateActivity.new(@revision, :approve, owner: current_user).call
        redirect_to @page, notice: "#{current_user.name} has successfully approved and published #{@revision.title}."
      else
        redirect_to @page, alert: "Oups! Something went wrong."
      end
    end

    def decline
      authorize @revision
      if @revision.decline
        CreateActivity.new(@revision, :decline, owner: current_user).call
        redirect_to [:edit, @page, @revision], notice: "#{current_user.name} has successfully declined a review for #{@revision.title}."
      else
        redirect_to [:edit, @page, @revision], alert: "Oups! Something went wrong."
      end
    end

    def restore
      authorize @revision
      if @revision.restore
        CreateActivity.new(@revision, :restore, owner: current_user).call
        redirect_to @page, notice: "#{current_user.name} has successfully restored a revision for #{@revision.title}."
      else
        redirect_to page_revisions_path(@page), alert: "Oups! Something went wrong."
      end
    end

    private

    def prepare_page
      polymorphic_resource_key = params.keys.select{|k| k.match('_id')}.first
      @page = Georgia::Page.find(params[polymorphic_resource_key])
    end

    def prepare_revision
      @revision = Revision.find(params[:id])
      @page = @revision.revisionable
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
      Notifier.notify_admins(message, url).deliver
    end

    def preview_url
      "#{@page.decorate.url}?r=#{@revision.id}"
    end

    def revision_params
      params.require(:revision).permit(:template, contents_attributes: [:text, :title, :locale, :excerpt, :keyword_list, :image_id, :id])
    end

  end
end