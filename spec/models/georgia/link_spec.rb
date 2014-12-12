require 'rails_helper'

describe Georgia::Link, type: :model do
  specify {expect(build(:georgia_link)).to be_valid}

  it { expect(subject).to belong_to :menu }

  describe 'slug' do

    it 'matches the end of the url' do
      @link = build(:georgia_link)
      @link.contents << build(:georgia_content, text: '/en/foo-3-4/bar-1-2')
      expect(@link.slug).to eq('bar-1-2')
    end

  end

  describe 'validation' do

    let(:link) {  build(:georgia_link) }

    describe 'url' do

      context 'when it starts with http or https' do

        it 'validates format of contents text to be a url' do
          link.contents << build(:georgia_content, text: 'http')
          link.contents << build(:georgia_content, text: 'https')
          expect(link).to be_valid
          expect(link).to have(:no).errors_on(:base)
        end

      end

      context 'when it starts with a forward /' do

        it 'validates format of contents text to be a url' do
          link.contents << build(:georgia_content, text: '/foo')
          link.contents << build(:georgia_content, text: '/bar')
          expect(link).to be_valid
          expect(link).to have(:no).errors_on(:base)
        end

      end

      context 'otherwise' do

        it 'is automatically corrected by prepending a foward slash' do
          link.contents = [build(:georgia_content, text: 'foo/bar')]
          expect(link).to be_valid
          expect(link.content.text).to match('/foo/bar')
        end

      end
    end

  end

end