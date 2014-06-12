module Georgia
  module UsersHelper

    def permissions_view
      Georgia.permissions.map{|section, actions| permission_table_tag(section, actions)}.join().html_safe
    end

    def permission_table_tag section, actions
      PermissionTablePresenter.new(self, section, actions).to_s
    end

  end
end