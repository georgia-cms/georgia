namespace :georgia do

  desc "Upgrade Georgia"
  task upgrade: :environment do
    Rake::Task['georgia:migrate:uuid'].execute
    Rake::Task['georgia:migrate:statuses'].execute
  end

  namespace :migrate do

    desc "Move Georgia::Status to OO Page"
    task statuses: :environment do

      published_status = Georgia::Status.find_by_name('Published')
      draft_status = Georgia::Status.find_by_name('Draft')

      published_status.pages.find_each do |page|
        draft = page.clone_as(Georgia::Draft)
        draft.save
        page.update_attribute(:type, 'Georgia::MetaPage')
        page.publish
      end

      draft_status.pages.find_each do |page|
        page.update_attribute(:type, 'Georgia::Draft')
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