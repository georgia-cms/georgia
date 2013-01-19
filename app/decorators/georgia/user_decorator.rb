module Georgia
  class UserDecorator < ApplicationDecorator

    def name
      [first_name, last_name].join(' ')
    end

    def roles_names
      model.roles.map(&:name).join(', ')
    end

  end
end