namespace :georgia do

  desc "Move Georgia::Status to OO Page"
  task statuses: :environment do
    puts "Initialize all pages with state 'draft'"
    Georgia::Page.update_all(state: 'draft')
  end

  desc "Create Revisions for each Page"
  task revisions: :environment do

    puts 'Migrating state, template and contents from pages to revisions.'
    Georgia::Page.class_eval do
      # Stop delegation
      def template
        Georgia::Page.where(id: self.id).pluck(:template).first
      end
    end

    Georgia::Page.find_each do |page|
      begin
        revision = page.revisions.create( state: 'published', template: page.template )
        Georgia::Content.where(contentable_id: page.id, contentable_type: 'Georgia::Page').update_all(contentable_id: revision.id, contentable_type: 'Georgia::Revision')
        Georgia::Slide.where(page_id: page.id).update_all(page_id: revision.id)
        Georgia::UiAssociation.where(page_id: page.id).update_all(page_id: revision.id)
        page.update_attribute(:revision_id, revision.id)
        page.save!
        page.publish if page.state == 'published'
      rescue => ex
        puts ex.message
      end
    end
    puts 'Migration completed.'
    puts "#{Georgia::Page.count} pages"
    puts "#{Georgia::Revision.count} revisions"

  end

end