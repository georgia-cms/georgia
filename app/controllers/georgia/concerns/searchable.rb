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
              fields(:title, :excerpt, :text, :keywords, :tags, :url, :template, :status_name)
            end
            facet :status_name, :template, :tag_list
            with(:status_name, params[:s]) unless params[:s].blank?
            with(:template, params[:t]) unless params[:t].blank?
            with(:tag_list).all_of(params[:tg]) unless params[:tg].blank?
            order_by params[:o], (params[:dir] || :desc) unless params[:o].blank?
            paginate(page: params[:page], per_page: (params[:per] || 25))
            instance_eval &model.extra_search_params if model.respond_to? :extra_search_params
          end
          @pages = Georgia::PageDecorator.decorate(@search.results)
        end

      end
    end
  end
end
