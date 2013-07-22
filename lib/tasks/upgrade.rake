namespace :georgia do

  desc "Upgrade Georgia"
  task upgrade: :environment do
    Rake::Task['georgia:migrate:statuses'].execute
  end

  namespace :migrate do

    desc "Move Georgia::Status to OO Page"
    task statuses: :environment do

      Georgia::Page.published.each do |page|
        draft = page.clone(as: Georgia::Draft)
        draft.save
        page.type = 'Georgia::PublishedPage'
        page.save(validate: false)
      end
      
      Georgia::Page.draft.each do |page|
        page.type = 'Georgia::Draft'
        page.save(validate: false)
      end

    end

  end

end