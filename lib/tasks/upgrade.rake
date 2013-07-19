namespace :georgia do

  desc "Upgrade Georgia"
  task upgrade: :environment do
    Rake::Task['georgia:migrate:statuses'].execute
  end

  namespace :migrate do

    desc "Move Georgia::Status to state_machine"
    task statuses: :environment do

      Georgia::Page.find_each do |page|
        status = page.status.name.parameterize.underscore
        page.state = status
        page.save!
      end

    end

  end

end