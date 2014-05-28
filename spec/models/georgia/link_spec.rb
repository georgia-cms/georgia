require 'spec_helper'

describe Georgia::Link do
  specify {build(:georgia_link).should be_valid}

  it { should belong_to :menu }

  describe 'slug' do

    it 'matches the end of the url' do
      @link = build(:georgia_link)
      @link.contents << build(:georgia_content, text: '/en/foo-3-4/bar-1-2')
      expect(@link.slug).to eq('bar-1-2')
    end

  end

  describe 'validation' do

    before :each do
      @link = build(:georgia_link)
    end

    describe 'url' do

      context 'when it starts with http or https' do

        it 'validates format of contents text to be a url' do
          @link.contents << build(:georgia_content, text: 'http')
          @link.contents << build(:georgia_content, text: 'https')
          @link.valid?.should be_true
          @link.should have(:no).errors_on(:base)
        end

      end

      context 'when it starts with a forward /' do

        it 'validates format of contents text to be a url' do
          @link.contents << build(:georgia_content, text: '/foo')
          @link.contents << build(:georgia_content, text: '/bar')
          @link.valid?.should be_true
          @link.should have(:no).errors_on(:base)
        end

      end

      context 'otherwise' do

        it 'is automatically corrected by prepending a foward slash' do
          @link.contents = [build(:georgia_content, text: 'foo/bar')]
          @link.valid?.should be_true
          expect(@link.content.text).to match('/foo/bar')
        end

      end
    end

  end

end