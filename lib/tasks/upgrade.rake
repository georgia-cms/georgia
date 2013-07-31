namespace :georgia do

  desc "Upgrade Georgia"
  task upgrade: :environment do
    Rake::Task['georgia:migrate:statuses'].execute
    Rake::Task['georgia:migrate:uuid'].execute
    Rake::Task['sunspot:reindex'].execute
  end

  namespace :migrate do

    desc "Move Georgia::Status to OO Page"
    task statuses: :environment do

      # Initialize all pages with state 'draft'
      Georgia::Page.update_all(state: 'draft')

      # Initialize all pages (no subclasses) as MetaPage
      Georgia::Page.where(type: nil).find_each do |page|
        page.update_attribute(:type, 'Georgia::MetaPage')
      end

      # All used-to-be published pages are turned into MetaPage and published
      published_status = Georgia::Status.find_by_name('Published')
      published_status.pages.find_each do |page|
        page.publish
      end

    end

    desc "Create a UUID per page"
    task uuid: :environment do
      Georgia::Page.find_each do |page|
        page.update_attribute(:uuid, UUIDTools::UUID.timestamp_create.to_s)
      end
    end

  end

end