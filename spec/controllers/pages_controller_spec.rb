require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers

  before :all do
    @page = create :georgia_page
  end

  describe "GET show" do

    it "has a status code of 200" do
      visit @page.url
      response.should be_ok
    end

  end

end
