namespace :georgia do

  task clean: :environment do

    puts 'Destroy all drafts, revisions and reviews.'
    ActiveRecord::Base.connection.execute("DELETE FROM georgia_pages WHERE type = 'Georgia::Draft';")
    ActiveRecord::Base.connection.execute("DELETE FROM georgia_pages WHERE type = 'Georgia::Review';")
    ActiveRecord::Base.connection.execute("DELETE FROM georgia_pages WHERE type = 'Georgia::Revision';")
    ActiveRecord::Base.connection.execute("DELETE FROM georgia_pages WHERE type = 'Nancy::JobOffer';")
    ActiveRecord::Base.connection.execute("DELETE FROM georgia_pages WHERE type ISNULL;")
    puts 'Destroy all drafts, revisions and reviews. Done.'

  end

  task upgrade: :environment do

    puts 'Migrating state, template and contents from pages to revisions.'

    module Georgia
      class FakePage < Georgia::Page
        has_many :contents, as: :contentable, dependent: :destroy, class_name: Georgia::Content
        has_many :slides, dependent: :destroy, foreign_key: :page_id
        has_many :ui_associations, dependent: :destroy, foreign_key: :page_id
        has_many :widgets, through: :ui_associations
      end
    end

    class Georgia::MetaPage < Georgia::FakePage;end
    class Event < Georgia::FakePage;end
    class PressRelease < Georgia::FakePage;end
    class Testimonial < Georgia::FakePage;end
    class Georgia::Post < Georgia::FakePage;end
    class Partner < Georgia::FakePage;end

    Georgia::Page.find_each do |page|
      begin
        unless page.type.nil?
          page.revisions.create( state: page.state, template: page.template )
          revision = page.revisions.first
          page.current_revision = revision
          page.contents.update_all(contentable_id: revision.id, contentable_type: 'Georgia::Revision')
          page.slides.update_all(page_id: revision.id)
          page.ui_associations.update_all(page_id: revision.id)
          revision.save!
          page.update_attribute(:public, true) if page.state == 'published'
          page.update_attribute(:type, nil) if page.is_a? Georgia::MetaPage
          page.save!
        end
      rescue => ex
        puts ex.message
        page.destroy
      end
    end
    puts 'Migration completed.'
    puts "#{Georgia::Page.count} pages"
    puts "#{Georgia::Revision.count} revisions"

  end

end