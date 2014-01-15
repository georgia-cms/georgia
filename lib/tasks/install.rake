namespace :georgia do

  desc 'Bootstrap Georgia with necessary instances'
  task install: :environment do

    # Create an admin user to start playing around
    # Also creates the two main roles
    support_user = Georgia::User.create(first_name: 'Dummy', last_name: 'Admin', email: 'admin@dummy.com', password: 'motion11', password_confirmation: 'motion11') do |user|
      user.roles << Georgia::Role.create(name: 'Admin')
      user.roles << Georgia::Role.create(name: 'Editor')
    end

    # Creates the default main UI sections
    Georgia::UiSection.create(name: 'Footer')
    Georgia::UiSection.create(name: 'Sidebar')

  end

end