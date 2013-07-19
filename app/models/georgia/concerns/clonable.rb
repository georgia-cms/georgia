require 'active_support/concern'

module Georgia
  module Concerns
    module Clonable
      extend ActiveSupport::Concern

      included do

        def clone options={}
          clone_with_associations(options)
        end

        def copy options={}
          options[:copy] ||= true
          copy = clone_with_associations(options)
          copy.save!
          copy
        end

        private

        # Clones a page and its associations (slides, widgets & contents)
        # Returns newly created clone
        def clone_with_associations options={}
          raise 'Instance must be persisted to be cloned' if self.new_record?

          if options[:as]
            new_clone = self.dup.becomes(options[:as])
          else
            new_clone = self.dup
          end

          if options[:copy]
            # alter the slug to have an original url
            new_clone.slug = self.slug + '-copy'
          end

          # clone tags
          self.tags.each do |tag|
            new_clone.tags << tag
          end

          # clone contents
          self.contents.each do |content|
            new_content = content.dup
            if options[:copy]
              # alter the title to keep original title unique
              new_content.title = "#{content.title} (Copy)"
            end
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

          new_clone
        end

      end

      module ClassMethods
      end
    end
  end
end