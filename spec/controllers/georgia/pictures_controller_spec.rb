require 'spec_helper'

describe Georgia::PicturesController do

  specify {FactoryGirl.create(:picture).should be_valid}

  describe "POST #update" do
    it "redirects to the media page after save" do
      post :update, picture: Factory.attributes_for(:picture)
      response.should redirect_to media_index_url
    end
  end

end