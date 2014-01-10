module Georgia
  class RevisionsController < ApplicationController

    load_and_authorize_resource class: Georgia::Revision

    before_filter :prepare_revision, except: :index
    before_filter :prepare_page, only: :index
    before_filter :prepare_content, only: [:edit, :update]

    def index
      @revisions = @page.revisions.order('created_at DESC').reject{|r| r == @page.current_revision}
    end

    def show
      redirect_to [:edit, @page, @revision]
    end

    def edit
      @ui_sections = Georgia::UiSection.all
    end

    # Stores a copy of the current revision before updating
    def update
      if RevisionPolicy.update(@page, @revision, params[:revision])
        redirect_to [:edit, @page, @revision], notice: "#{@revision.title} was successfully updated."
      else
        redirect_to [:edit, @page, @revision], alert: @revision.errors.full_messages.join('. ')
      end
    end

    def destroy
      @revision.destroy
      redirect_to page_revisions_path(@page), notice: "#{@revision.title or 'Revision'} was successfully deleted."
    end

    # Sends revision to main_app router
    # FIXME: bypass this once Georgia will be loaded on root
    def preview
      redirect_to main_app.preview_page_path(id: @page.id, revision_id: @revision.id)
    end

    def review
      @revision.review
      notify("#{current_user.name} is asking you to review #{@revision.title}.", [:edit, @page, @revision])
      redirect_to [:edit, @page, @revision], notice: "You successfully submited #{@revision.title} for review."
    end

    def approve
      @revision.approve
      redirect_to @page, notice: "#{current_user.name} has successfully approved and published #{@revision.title}."
    end

    def decline
      @revision.decline
      redirect_to [:edit, @page, @revision], notice: "#{current_user.name} has successfully published #{@revision.title}."
    end

    def restore
      @revision.restore
      redirect_to @page, notice: "#{current_user.name} has successfully published #{@revision.title}."
    end

    private

    def prepare_page
      polymorphic_resource_key = params.keys.select{|k| k.match('_id')}.first
      @page = Georgia::Page.find(params[polymorphic_resource_key])
    end

    def prepare_revision
      @revision = Revision.find(params[:id])
      @page = @revision.page
    end

    def prepare_content
      if locale = params[:locale]
        @content = @revision.contents.select{|c| c.locale.to_s == locale}.first
        @content ||= Georgia::Content.new(locale: locale) if locale
      else
        @content = @revision.content
      end
    end

    def notify(message, url)
      Notifier.notify_admins(message, url).deliver
    end

  end
end