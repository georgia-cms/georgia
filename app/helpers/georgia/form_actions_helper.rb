module Georgia
  module FormActionsHelper

    def link_to_preview_revision(page, revision, options={})
      options[:method] = :post
      options[:target] = '_blank'
      revision ||= page.last_revision
      link_to "#{icon_tag('icon-eye-open')} Preview".html_safe, main_app.preview_page_path(page, page: revision.revision_attributes), options
    end

    def link_to_revert revision
      link_to "#{icon_tag('icon-retweet')} Revert".html_safe, georgia.revert_version_path(revision), method: :post, class: 'btn'
    end

  end
end
