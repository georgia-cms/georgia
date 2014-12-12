require 'rails_helper'

describe PagesController, type: :controller do

  describe "GET show" do

    it "has a status code of 200" do
      page = create(:georgia_page)
      visit page.url
      expect(response).to be_ok
    end

  end

end
