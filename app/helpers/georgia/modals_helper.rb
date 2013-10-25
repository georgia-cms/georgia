module Georgia
  module ModalsHelper

    def link_to_close
      link_to icon_tag('remove'), "#", class: 'btn-close js-close'
    end

  end
end