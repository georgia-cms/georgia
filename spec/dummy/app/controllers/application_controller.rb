class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @page = Georgia::Page.first
  end
end
