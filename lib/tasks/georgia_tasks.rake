namespace :georgia do

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