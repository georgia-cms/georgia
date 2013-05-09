require 'active_support/concern'

module Georgia
  module Concerns
    module Searchable
      extend ActiveSupport::Concern

      def index
        redirect_to action: :search
      end

      def search
        session[:search_params] = params
        @search = model.search do
          fulltext params[:query] do
            fields(:url, :status_name, :template, :titles, :excerpts, :contents, :keywords, :tags)
          end
          facet :status_name, :template, :tag_list
          #with(:type, nil) # ensure it's not a subtype of model
          with(:status_name, params[:s]) unless params[:s].blank?
          with(:template, params[:t]) unless params[:t].blank?
          with(:tag_list).all_of(params[:tg]) unless params[:tg].blank?
          order_by params[:o], (params[:dir] || :desc) unless params[:o].blank?
          paginate(page: params[:page], per_page: (params[:per] || 25))
        end
        @pages = Georgia::PageDecorator.decorate @search.results
      end
    end
  end
end
