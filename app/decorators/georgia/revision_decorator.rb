module ActsAsRevisionable
  class RevisionRecord < Georgia::ApplicationDecorator

    def current? instance
      model.id == instance.revision_id
    end

    def changed_by
      begin
        Georgia::UserDecorator.decorate(Georgia::User.find(revision_attributes['updated_by_id'])).name
      rescue
        'Unknown'
      end
    end

    def changed_at
      h.time_ago_in_words(model.created_at.in_time_zone)
    end

    def changes_list
      revision_attributes
    end

    protected

    def extract_changes(changes_hash={})
      return "No changes recorded" unless changes_hash and !changes_hash.empty?
      changes_array = []
      changes_hash.each do |key, value|
        changes_array << "<h4>#{key}:</h4>"
        changes_array << format_change(value[1],value[0])
      end
      changes_array.join().html_safe
    end

    def format_change(current, original)
      if current.to_s.length > 255 or original.to_s.length > 255
        Differ.diff(current.to_s, original.to_s).format_as(:html)
      else
        Differ.diff_by_word(current.to_s, original.to_s).format_as(:html)
      end
    end
  end
end