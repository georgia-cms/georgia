class PagesController < ApplicationController

  include Georgia::Concerns::Frontendable

  before_filter :prepare_menus

  private

  def prepare_menus
    @main_menu = Georgia::Menu.where(name: 'Main').includes(links: :contents).first
  end

end