namespace :georgia do

  task upgrade: :environment do
    Rake::Task['georgia:pages:update_url'].execute
    Rake::Task['georgia:pages:reindex'].execute
  end

  namespace :pages do

    task update_url: :environment do
      Georgia::Page.find_each(&:set_url)
      Georgia::Page.reindex
    end

    task reindex: :environment do
      Georgia::Page.reindex
    end

  end

end