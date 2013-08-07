namespace :georgia do

  desc 'Bootstrap Georgia with necessary instances'
  task install: :environment do

    # Create an admin user to start playing around
    # Also creates the two main roles
    support_user = Georgia::User.create(first_name: 'Motion Eleven', last_name: 'Support', email: 'webmaster@motioneleven.com', password: 'motion11', password_confirmation: 'motion11') do |user|
      user.roles << Georgia::Role.create(name: 'Admin')
      user.roles << Georgia::Role.create(name: 'Editor')
    end

    # Creates the default main UI sections
    Georgia::UiSection.create(name: 'Footer')
    Georgia::UiSection.create(name: 'Sidebar')

    # Creates the home page, mother of all pages
    page = Georgia::Page.create(slug: 'home')
    revision = Georgia::Revision.create(state: :draft, template: 'one-column')
    content = Georgia::Content.create(locale: 'en', title: 'Home')
    revision.contents << content
    page.revisions << revision
    page.current_revision = revision
    page.save
    Georgia::Page.reindex

  end

end