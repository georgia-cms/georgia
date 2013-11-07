module Georgia
  module ModalsHelper
    def link_to_close
      content_tag :button, icon_tag('times'), class: 'close', data: {dismiss: 'modal'}, aria: {hidden: true}, type: 'button'
    end
  end
end