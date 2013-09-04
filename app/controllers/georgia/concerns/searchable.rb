require 'active_support/concern'

module Georgia
  module Concerns
    module Searchable
      extend ActiveSupport::Concern
      include Helpers

      included do

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
            if model == Georgia::Page
              with(:type, nil) # Georgia::Page is sort of abstract and doesn't save a type
            else
              with(:type, model.to_s) # ensure pages indexed in the wrong bucket don't get displayed
            end
            with(:state, params[:s]) unless params[:s].blank?
            with(:template, params[:t]) unless params[:t].blank?
            with(:tag_list).all_of(params[:tg]) unless params[:tg].blank?
            order_by (params[:o] || :updated_at), (params[:dir] || :desc)
            paginate(page: params[:page], per_page: (params[:per] || 25))
            instance_eval &model.extra_search_params if model.respond_to? :extra_search_params
          end
          @pages = Georgia::PageDecorator.decorate_collection(@search.results)
        end

      end
    end
  end
end
