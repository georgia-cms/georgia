module Georgia
  class UserDecorator < ApplicationDecorator
    decorates :user, class: Georgia::User

    def name
      first_name + ' ' + last_name if (first_name and last_name)
    end

    def roles
      model.roles.map(&:name).join(', ')
    end

  end
end