require 'active_support/concern'

module Georgia
  module Concerns
    module Clonable
      extend ActiveSupport::Concern

      included do

        # Clones a page and its associations (slides, widgets & contents)
        # Returns newly created clone
        def clone_with_associations
          new_clone = self.dup

          # alter the slug to have an original url
          new_clone.slug = self.slug + '-copy'

          # clone contents
          self.contents.each do |content|
            new_content = content.dup
            # alter the title to keep original title unique
            new_content.title = "#{content.title} (Copy)"
            new_content.save!
            new_clone.contents << new_content
          end

          # clone ui_associations
          self.ui_associations.each do |ui_assoc|
            new_ui_assoc = ui_assoc.dup
            new_ui_assoc.save!
            new_clone.ui_associations << new_ui_assoc
          end

          # clone slides and its contents
          self.slides.each do |slide|
            new_slide = slide.dup
            new_slide.contents = slide.contents.dup
            new_slide.save!
            new_clone.slides << new_slide
          end

          new_clone.save!

          new_clone
        end

      end

      module ClassMethods
      end
    end
  end
end