module Georgia
  class MenuDecorator < ApplicationDecorator
    decorates :menu, class: Georgia::Menu
    decorates_association :link, with: Georgia::LinkDecorator
  end
end