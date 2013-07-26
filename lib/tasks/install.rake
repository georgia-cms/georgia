namespace :georgia do

  desc 'Bootstrap Georgia with necessary instances'
  task install: :environment do

    # Create an admin user to start playing around
    # Also creates the two main roles
    support_user = Georgia::User.create(first_name: 'Motion Eleven', last_name: 'Support', email: 'webmaster@motioneleven.com', password: 'motion11', password_confirmation: 'motion11') do |user|
      user.roles << Georgia::Role.create(name: 'Admin')
      user.roles << Georgia::Role.create(name: 'Editor')
    end

    # Create the publishing statuses
    Georgia::Status.create(name: 'Published', label: 'success', icon: 'icon-eye-open')
    Georgia::Status.create(name: 'Pending Review', label: 'warning', icon: 'icon-time')
    Georgia::Status.create(name: 'Draft', label: 'error', icon: 'icon-eye-close')
    Georgia::Status.create(name: 'Incomplete', label: 'info', icon: 'icon-exclamation-sign')

    # Creates the default main UI sections
    Georgia::UiSection.create(name: 'Footer')
    Georgia::UiSection.create(name: 'Sidebar')

    # Creates the home page, mother of all pages
    page = Georgia::MetaPage.create(slug: 'home') do |page|
      page.contents << Georgia::Content.new(
        locale: 'en',
        title: 'Home'
      )
    end
    Georgia::Page.reindex

  end

end