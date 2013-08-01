module Georgia
  class Clone

    attr_accessor :instance, :duplicate

    def initialize instance
      raise 'Instance must be persisted to be cloned' if instance.new_record?
      @instance = instance
      @duplicate = instance.dup
    end

    # Returns an exact persisted version of itself with all Georgia::Page associations
    def clone
      clone_with_associations
      duplicate
    end

    # Returns an exact persisted version of itself with all Georgia::Page associations
    # The result is altered to return an object of a different class supported by STI
    def clone_as klass
      duplicate.update_attribute(:type, klass.to_s)
      clone
      Sunspot.index! duplicate
      duplicate.becomes(klass)
    end

    # Returns an exact persisted version of itself with all Georgia::Page associations
    # The resulting instance has a '(Copy)' title and '-copy' slug
    def copy
      alter_uuid
      alter_slug
      clone
      alter_title
      duplicate.save!
      duplicate
    end

    private

    def clone_with_associations
      # Gives an ID to store associations
      duplicate.save

      # clone associations
      clone_tags
      clone_contents
      clone_ui_associations
      clone_slides
    end

    def clone_contents
      instance.contents.each do |content|
        duplicate.contents << clone_content(content, duplicate)
      end
      duplicate
    end

    def clone_ui_associations
      instance.ui_associations.each do |ui_assoc|
        new_ui_assoc = ui_assoc.dup
        duplicate.ui_associations << new_ui_assoc
      end
      duplicate
    end

    def clone_slides
      instance.slides.each do |slide|
        new_slide = slide.dup
        slide.contents.each do |content|
          clone_content(content, new_slide)
        end
        duplicate.slides << new_slide
      end
      duplicate
    end

    def clone_tags
      duplicate.tag_list = instance.tag_list
      duplicate
    end

    def clone_content(content, contentable)
      new_content = content.dup
      new_content.keyword_list = content.keyword_list
      contentable.save unless contentable.persisted?
      new_content.contentable = contentable
      new_content.save
      new_content
    end

    # alter the uuid to have an original uuid
    def alter_uuid
      duplicate.update_attribute(:uuid, UUIDTools::UUID.timestamp_create.to_s)
    end

    # alter the slug to have an original url
    def alter_slug
      duplicate.update_attribute(:slug, duplicate.slug + '-copy')
    end

    # alter the title to keep original title unique
    def alter_title
      duplicate.contents.each do |content|
        content.update_attribute(:title, "#{content.title} (Copy)")
      end
    end

  end
end