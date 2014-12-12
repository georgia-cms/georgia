require 'rails_helper'

describe Georgia::Content, type: :model do

  specify {expect(build(:georgia_content)).to be_valid}

  it { expect(subject).to respond_to :title, :text, :excerpt, :keywords, :locale, :image_id }

  it { expect(subject).to belong_to :image }
  it { expect(subject).to belong_to :contentable }

  it { expect(subject).to ensure_length_of(:title).is_at_most(255) }

  describe '#keywords' do

    it 'returns a list of tags' do
      content = create(:georgia_content, keyword_list: 'tag1, tag2, tag3')
      expect(content.keywords.first).to be_a ActsAsTaggableOn::Tag
    end

  end

end