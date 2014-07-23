module Georgia
  class CloneRevision

    def initialize revision, status: 'revision', revised_by_id: nil
      raise 'Revision must be persisted to be copied' if revision.new_record?
      @revision = revision
      @status = status
      @revised_by_id = revised_by_id
    end

    # Returns a copy of the revision in 'revision' status
    def call
      clone_revision
    end

    def self.create revision, attributes={}
      clone = new(revision, attributes).call
      clone.save!
      clone
    end

    private

    def clone_revision
      @duplicate_revision = Georgia::Revision.new(template: @revision.template, status: @status, revisionable: @revision.revisionable, revised_by_id: @revised_by_id) do |r|
        r.contents = clone_contents
        r.ui_associations = clone_ui_associations
        r.slides = clone_slides
      end
      @duplicate_revision
    end

    def clone_contents
      @revision.contents.map{|c| clone_content(c)}
    end

    def clone_ui_associations
      @revision.ui_associations.map{|ui_assoc| clone_ui_association(ui_assoc)}
    end

    def clone_slides
      @revision.slides.map do |slide|
        new_slide = Georgia::Slide.new(page_id: slide.page_id)
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
        page_id: ui_assoc.page_id,
        widget_id: ui_assoc.widget_id,
        ui_section_id: ui_assoc.ui_section_id
      )
    end

  end
end