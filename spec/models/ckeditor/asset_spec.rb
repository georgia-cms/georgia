require 'spec_helper'

describe Ckeditor::Asset do

  it "count the number of tags" do
    picture = Ckeditor::Asset.new

    picture.tag_list = "tag1, tag2, tag3"
    picture.tags.count.should eq(3)
  end

  describe '.save' do

  end


end