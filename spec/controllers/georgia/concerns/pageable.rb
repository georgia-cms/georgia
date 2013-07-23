require 'spec_helper'

describe Georgia::Concerns::Pageable do
  it "should retrieve the model name of the controller" do
    controller = Georgia::MetaPagesController.new
    controller.model.name.should eq("Georgia::MetaPage")
  end
end
