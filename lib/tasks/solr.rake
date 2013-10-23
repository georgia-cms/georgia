namespace :solr do

  namespace :messages do

    desc 'Reindex messages on solr'
    task reindex: :environment do
      Georgia::Message.reindex
    end

  end

  namespace :reindex do

    desc 'Reindex assets on solr'
    task assets: :environment do
      Ckeditor::Asset.reindex
    end

  end

  namespace :pages do

    desc 'Reindex pages on solr'
    task reindex: :environment do
      Georgia::Page.reindex
    end

  end

end