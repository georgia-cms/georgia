module Georgia
  class Clone

    attr_accessor :instance, :duplicate

    def initialize instance
      raise 'Instance must be persisted to be copied' if instance.new_record?
      @instance = instance
      @duplicate = instance.class.new
    end

    # Returns an exact persisted version of itself with all Georgia::Page associations
    # The resulting instance has a '(Copy)' title and '-copy' slug
    def copy
      copy_page
      duplicate.current_revision = clone_current_revision
      alter_slug
      alter_title
      duplicate.save!
      duplicate
    end

    # Returns a copy of the current revision in 'draft' state
    def draft
      clone_current_revision(state: 'draft')
    end

    # Returns a copy of the current revision in 'revision' state
    def store
      @instance.revisions << clone_current_revision(state: 'revision')
      @instance.save!
    end

    private

    def copy_page
      duplicate.ancestry = instance.ancestry
      duplicate.tag_list = instance.tag_list
    end

    def clone_current_revision options={}
      state = options.fetch(:state, 'draft')
      @duplicate_revision = Georgia::Revision.new(template: instance.current_revision.template, state: state) do |r|
        r.contents = clone_contents
        r.ui_associations = clone_ui_associations
        r.slides = clone_slides
      end
      @duplicate_revision
    end

    def clone_contents
      instance.current_revision.contents.map{|c| clone_content(c)}
    end

    def clone_ui_associations
      instance.current_revision.ui_associations.map{|ui_assoc| clone_ui_association(ui_assoc)}
    end

    def clone_slides
      instance.current_revision.slides.map do |slide|
        new_slide = Georgia::Slide.new
        slide.contents.each do |content|
          new_slide.contents << clone_content(content)
        end
        new_slide
      end
    end

    def clone_content(content)
      Georgia::Content.new(
        locale: content.locale,
        text: content.text,
        title: content.title,
        excerpt: content.excerpt,
        image_id: content.image_id,
        keyword_list: content.keyword_list
      )
    end

    def clone_ui_association(ui_assoc)
      Georgia::UiAssociation.new(
        widget_id: ui_assoc.widget_id,
        ui_section: ui_assoc.ui_section
      )
    end

    # alter the slug to add '-copy' at the end and keep url unique
    def alter_slug
      duplicate.slug = "#{instance.slug}-copy"
    end

    # alter the title to keep original title unique
    def alter_title
      duplicate.current_revision.contents.each do |content|
        content.update_attribute(:title, "#{content.title} (Copy)")
      end
    end

  end
end