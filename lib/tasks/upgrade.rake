namespace :georgia do

  task upgrade: :environment do
    Rake::Task['georgia:roles:create_guest'].execute
    Rake::Task['georgia:roles:unset_editor_from_admin'].execute
  end

  namespace :roles do

    task create_guest: :environment do
      Georgia::Role.find_or_create_by_name('Guest')
    end

    task unset_editor_from_admin: :environment do
      admin_role = Georgia::Role.find_by_name('Admin')
      editor_role = Georgia::Role.find_by_name('Editor')

      Georgia::User.admins.find_each do |user|
        # remove all editor role associations
        user.roles.delete(editor_role)

        # remove doubled associations
        user.roles.delete(admin_role)
        user.roles << admin_role
      end
    end

  end

end