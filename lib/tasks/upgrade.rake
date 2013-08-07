namespace :georgia do

  namespace :upgrade do

    task migrate_to_revisions: :environment do

      puts 'Migrating state, template and contents from pages to revisions.'

      Georgia::Page.find_each do |page|
        page.revisions.create( state: page.state, template: page.template, revisionable: page ) do |rev|
          page.contents.update_all (contentable: rev)
          page.slides.update_all (revision: rev)
          page.ui_associations.update_all (revision: rev)
        end
      end

      puts 'Migration completed.'

    end

  end

end