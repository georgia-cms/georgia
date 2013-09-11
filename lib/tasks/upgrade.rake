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
      attr_accessible :template
      has_many :contents, as: :contentable, dependent: :destroy, class_name: Georgia::Content
      has_many :slides, dependent: :destroy, foreign_key: :page_id
      has_many :ui_associations, dependent: :destroy, foreign_key: :page_id
      has_many :widgets, through: :ui_associations

      # Stop delegation
      def template
        Georgia::Page.where(id: self.id).pluck(:template).first
      end
    end

    Georgia::Page.find_each do |page|
      begin
        revision = page.revisions.create( state: page.state, template: page.template )
        page.current_revision = revision
        page.contents.update_all(contentable_id: revision.id, contentable_type: 'Georgia::Revision')
        page.slides.update_all(page_id: revision.id)
        page.ui_associations.update_all(page_id: revision.id)
        revision.save!
        page.update_attribute(:public, true) if page.state == 'published'
        page.save!
      rescue => ex
        puts ex.message
      end
    end
    puts 'Migration completed.'
    puts "#{Georgia::Page.count} pages"
    puts "#{Georgia::Revision.count} revisions"

  end

end