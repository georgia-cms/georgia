module Georgia
  class PermissionTablePresenter < Presenter

    def initialize context, title, actions
      super
      @title = title
      @actions = actions
    end

    def to_s
      html = ActiveSupport::SafeBuffer.new
      html << title_tag
      html << table
      html.to_s.html_safe
    end

    private

    def title_tag
      content_tag :h2, @title.to_s.titleize
    end

    def table
      content_tag :table, class: 'table table-results' do
        thead + tbody
      end
    end

    def thead
      content_tag(:thead) do
        content_tag(:tr) do
          content_tag(:th, 'Actions') +
          Georgia.roles.map{|role| content_tag(:th, role.to_s.titleize, class: 'role') }.join.html_safe
        end
      end
    end

    def tbody
      content_tag(:tbody, action_rows)
    end

    def action_rows
      @actions.map do |action, permissions|
        content_tag(:tr) do
          content_tag(:td, action.to_s.titleize) +
          Georgia.roles.map{|role| permission_cell(permissions[role.to_sym]) }.join.html_safe
        end
      end.join.html_safe
    end

    def permission_cell permission
      content_tag(:td, permission_icon(permission), class: "text-center #{permission_class(permission)}")
    end

    def permission_icon permission
      icon_tag(
        case permission
        when true then 'check'
        when false then 'times'
        when :partial then 'minus'
        else 'times'
        end
      )
    end

    def permission_class permission
      case permission
      when true then 'success'
      when false then 'danger'
      when :partial then 'warning'
      else 'danger'
      end
    end

  end
end