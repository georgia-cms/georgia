module Georgia
  class PageDecorator < Georgia::ApplicationDecorator
    decorates_association :current_revision

    delegate :status_tag, :excerpt_or_text, to: :current_revision

    def template_path
      "pages/templates/#{current_revision.template}"
    end

  end
end