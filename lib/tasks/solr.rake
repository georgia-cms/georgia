namespace :solr do

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