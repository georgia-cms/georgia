module Georgia
  module StatesHelper

    def state_label_tag state
      content_tag(:span, state.try(:humanize), class: "label label-#{css_class(state)}")
    end

    def css_class state, options={}
      case state
      when 'draft' then 'warning'
      when 'pending' then 'info'
      when 'published' then 'success'
      end
    end

  end
end