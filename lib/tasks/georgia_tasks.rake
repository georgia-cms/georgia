namespace :georgia do
  desc 'Bootstrap Georgia with necessary instances'
  task setup: :environment do

    # Create an admin user to start playing around
    # Also creates the two main roles
    Georgia::User.create(first_name: 'Mathieu', last_name: 'Gagne', email: 'mathieu@motioneleven.com', password: 'motion11', password_confirmation: 'motion11') do |user|
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

  end

  desc 'Migrates all data from old setup into georgia'
  task migrate: :environment do

    Georgia::Message.destroy_all
    Message.find_each do |message|
      Georgia::Message.create(
        name: message.name,
        email: message.email,
        subject: message.subject,
        message: message.message
        )
    end

    Georgia::Page.destroy_all
    Page.find_each do |page|
      Georgia::Page.create(slug: page.slug, parent_id: page.parent_id) do |gp|
        gp.contents << Georgia::Content.create(
          locale: 'en',
          title: page.title,
          text: page.content,
          keywords: page.seo_meta_keywords,
          excerpt: page.seo_meta_description
          )
      end
    end

  end

  desc "Publish all pages with first user as publisher"
  task publish: :environment do

    @current_user = Georgia::User.first

    Georgia::Page.find_each do |page|
      page.publish(@current_user).save!
    end

  end

  namespace :ancestry do
    desc "Saves ancestry from legacy parent_id"
    task load: :environment do

      Georgia::Page.find_each do |page|
        if parent = page.attributes['parent_id']
          begin
            page.parent = Georgia::Page.find(parent)
            page.save!
          rescue ActiveRecord::RecordNotFound
            puts 'Page not found'
          end
        end
      end

    end
  end
end