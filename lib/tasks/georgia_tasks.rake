namespace :georgia do

  desc 'Bootstrap Georgia with necessary instances'
  task setup: :environment do

    # Create an admin user to start playing around
    # Also creates the two main roles
    support = Georgia::User.create(first_name: 'Motion Eleven', last_name: 'Support', email: 'webmaster@motioneleven.com', password: 'motion11', password_confirmation: 'motion11') do |user|
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
    page = Georgia::Page.create(slug: 'home') do |page|
      page.contents << Georgia::Content.create(locale: 'en')
    end
    page.publish(support).save!

  end

  namespace :migrate do

    desc "Saves ancestry from legacy parent_id"
    task ancestry: :environment do

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

    desc "Saves keywords to tags list"
    task tags: :environment do

      Georgia::Content.find_each do |content|
        content.keyword_list = content.keywords
        content.save
      end

    end
  end

  desc "Purge assets that don't have an existing file in the cloud"
  task purge: :environment do
    count = 0
    Ckeditor::Asset.find_each do |asset|
      begin
        if !asset.data.file.exists?
          asset.destroy
          count += 1
        end
      end
    end
    puts "#{count} assets purged."
  end


end