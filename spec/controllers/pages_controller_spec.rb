require 'rails_helper'

describe PagesController, type: :controller do

  describe "GET show" do

    it "has a status code of 200" do
      page = create(:georgia_page, slug: 'foobar')
      get :show, request_path: 'foobar'
      expect(response).to be_success
    end

  end

end
