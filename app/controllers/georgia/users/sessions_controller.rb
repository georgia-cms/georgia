module Georgia
  module Users
    class SessionsController < ::Devise::SessionsController
      layout 'georgia/devise'
    end
  end
end