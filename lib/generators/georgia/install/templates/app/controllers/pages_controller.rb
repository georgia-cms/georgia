class PagesController < ApplicationController

  include Georgia::Concerns::Frontendable

  before_filter :prepare_menus

  private

  def prepare_menus
    @main_menu = Georgia::Menu.find_by_name('Main', include: {links: :contents})
  end

end