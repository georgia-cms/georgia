module Georgia
  class PagesController < ApplicationController

    include Georgia::Concerns::Helpers

    before_filter :prepare_new_page, only: [:search]
    before_filter :prepare_page, only: [:show, :edit, :settings, :update, :copy, :preview, :flush_cache, :draft, :publish, :unpublish]

    def show
      redirect_to [:edit, @page]
    end

    # Edit current revision
    def edit
      redirect_to edit_page_revision_path(@page, @page.current_revision)
    end

    # Edit current page
    def settings
    end

    # Create page, load first current revision and js redirect to revisions#edit
    def create
      @page = model.new(slug: params[:title].try(:parameterize))
      if @page.save
        @page.revisions.create(template: Georgia.templates.first) do |rev|
          rev.contents << Georgia::Content.new(locale: I18n.default_locale, title: params[:title])
        end
        @page.update_attribute(:current_revision, @page.revisions.first)
      end
    end

    # Update page settings
    def update
      @page.update_attributes(params[:page])

      if @page.update_attributes(params[:page])
        respond_to do |format|
          format.html { render :settings, notice: "#{decorate(@revision).title} was successfully updated." }
          format.js { render layout: false }
        end
      else
        respond_to do |format|
          format.html { render :settings, notice: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    # Creates a copy of a page and redirects to its revisions#edit
    def copy
      @copy = @page.copy
      redirect_to [:edit, @copy], notice: "Do not forget to change your url"
    end

    # Destroy multiple pages from table checkboxes
    def destroy
      ids = params[:id].split(',')
      if @pages = model.destroy(ids)
        render layout: false
      else
        head :internal_server_error
      end
    end

    # Flush this page's cache
    def flush_cache
      if expire_action(@page.cache_key)
        redirect_to :back, notice: "Cache was successfully cleared for #{@page.url}"
      else
        redirect_to :back, alert: "Oups. Either there wasn't any cache to start with or something went wrong."
      end
    end

    # Creates a draft revision
    def draft
      @draft = @page.draft
      redirect_to [:edit, @page, @draft], notice: "You successfully started a new draft of #{@draft.title}. Submit for review when completed."
    end

    # Publishes the page
    def publish
      @page.publish
      redirect_to :back, notice: "#{current_user.name} has successfully published #{@page.title} #{instance_name}."
    end

    # Unpublishes the page
    def unpublish
      @page.unpublish
      redirect_to :back, notice: "#{current_user.name} has successfully unpublished #{@page.title} #{instance_name}."
    end

    # Sorts subpages/children from pages#settings
    def sort
      if params[:page]
        params[:page].each_with_index do |id, index|
          model.update_all({position: index+1}, {id: id})
        end
      end
      render nothing: true
    end

    def index
      redirect_to action: :search
    end

    def search
      session[:search_params] = params
      @search = model.search do
        fulltext params[:query] do
          fields(:title, :excerpt, :text, :keywords, :tags, :url, :template)
        end
        facet :state, :template, :tag_list
        # ensure pages indexed in the wrong bucket don't get displayed
        with(:class_name, model.to_s)
        with(:state, params[:s]) unless params[:s].blank?
        with(:template, params[:t]) unless params[:t].blank?
        with(:tag_list).all_of(params[:tg]) unless params[:tg].blank?
        order_by (params[:o] || :updated_at), (params[:dir] || :desc)
        paginate(page: params[:page], per_page: (params[:per] || 25))
        instance_eval &model.extra_search_params if model.respond_to? :extra_search_params
      end
      @pages = Georgia::PageDecorator.decorate_collection(@search.results)
    end

    private

    def prepare_new_page
      @page = model.new
    end

    def prepare_page
      @page = model.find(params[:id]).decorate
    end

  end
end
