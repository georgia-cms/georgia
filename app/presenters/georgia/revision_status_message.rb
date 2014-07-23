module Georgia
  class RevisionStatusMessage

    include Pundit

    attr_reader :current_user

    def initialize current_user, page, revision, draft_revision=nil
      @current_user = current_user
      @page = page
      @revision = revision
      @draft_revision = draft_revision
    end

    def partial
      case @revision.status
      when 'draft' then draft_partial_sorter
      when 'review' then review_partial_sorter
      when 'revision' then revision_partial_sorter
      when 'published' then published_partial_sorter
      end
    end

    private

    def draft_partial_sorter
      if policy(@revision).approve?
        'request_review'
      elsif current_owner?
        'review'
      else
        'insufficient_rights'
      end
    end

    def review_partial_sorter
      if current_owner?
        'awaiting_review'
      elsif policy(@revision).approve?
        'review'
      else
        'insufficient_rights'
      end
    end

    def revision_partial_sorter
      if current_revision? and policy(@revision).approve?
        nil
      elsif current_revision? and !policy(@revision).approve?
        'insufficient_rights'
      elsif !current_revision? and policy(@revision).approve?
        'edit_current_revision'
      else
        'start_draft'
      end
    end

    def published_partial_sorter
      if !policy(@revision).approve?
        'insufficient_rights'
      end
    end

    def current_revision?
      @is_current_revision ||= @page.current_revision == @revision
    end

    def current_owner?
      @is_current_owner ||= @revision.user == @current_user
    end

  end
end