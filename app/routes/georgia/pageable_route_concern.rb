module Georgia
  module PageableRouteConcern
    def self.included(base)
      base.instance_eval do
        concern :pageable do

          collection do
            get :search
            post :sort
            post :publish
            post :unpublish
            delete '/', to: :destroy
          end

          member do
            get :copy
            get :settings
          end

          resources :revisions do
            member do
              get :preview
              get :draft
              get :request_review
              get :approve
              get :store
              get :decline
              get :restore
            end
          end
        end
      end
    end
  end
end