module Georgia
  class MenuItemDecorator < ApplicationDecorator
    decorates :menu_item, class: Georgia::MenuItem
    decorates_association :page, class: Georgia::Page
  end
end