module Georgia
  class MenuDecorator < ApplicationDecorator
    decorates :menu, class: Georgia::Menu
    decorates_association :menu_item, class: Georgia::MenuItem
  end
end