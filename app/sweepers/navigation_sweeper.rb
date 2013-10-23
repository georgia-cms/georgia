class NavigationSweeper < ActionController::Caching::Sweeper
  observe Georgia::Menu

  # Clear all cache when updating the menu.
  # Menu is present on all pages. It also changes for each page because of the 'active' link.
  def sweep(menu)
    Rails.cache.clear
  end
  alias_method :after_save, :sweep
  alias_method :after_touch, :sweep

end