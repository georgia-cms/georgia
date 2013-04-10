require 'spec_helper'

describe Georgia::Content do
  specify {FactoryGirl.build(:georgia_content).should be_valid}

  it { should respond_to :title, :text, :excerpt, :keywords, :locale, :image_id }

  it { should belong_to :image }
  it { should belong_to :contentable }

  it { should ensure_length_of(:title).is_at_most(255) }

  describe '#keywords' do

    it 'returns a list of tags' do
      content = FactoryGirl.create(:georgia_content, keyword_list: 'tag1, tag2, tag3')
      content.keywords.should be_a Array
      content.keywords.first.should be_a ActsAsTaggableOn::Tag
    end

  end

end