require 'spec_helper'

describe Georgia::Link do
  specify {FactoryGirl.build(:georgia_link).should be_valid}

  it { should belong_to :menu }

  describe 'slug' do

    it 'matches the end of the url' do
      @link = FactoryGirl.build(:georgia_link)
      @link.contents << FactoryGirl.build(:georgia_content, text: '/en/foo-3-4/bar-1-2')
      expect(@link.slug).to eq('bar-1-2')
    end

  end

  describe 'validation' do

    before :each do
      @link = FactoryGirl.build(:georgia_link)
    end

    it 'validates presence of contents title' do
      @link.contents << FactoryGirl.build(:georgia_content, title: nil)
      @link.valid?.should be_false
    end

    it 'validates presence of contents text' do
      @link.contents << FactoryGirl.build(:georgia_content, text: nil)
      @link.valid?.should be_false
    end

    describe 'url' do

      context 'when it starts with http or https' do

        it 'validates format of contents text to be a url' do
          @link.contents << FactoryGirl.build(:georgia_content, text: 'http')
          @link.contents << FactoryGirl.build(:georgia_content, text: 'https')
          @link.valid?.should be_true
          @link.should have(:no).errors_on(:base)
        end

      end

      context 'when it starts with a forward /' do

        it 'validates format of contents text to be a url' do
          @link.contents << FactoryGirl.build(:georgia_content, text: '/foo')
          @link.contents << FactoryGirl.build(:georgia_content, text: '/bar')
          @link.valid?.should be_true
          @link.should have(:no).errors_on(:base)
        end

      end

      context 'otherwise' do

        it 'yields an error' do
          @link.contents = [FactoryGirl.build(:georgia_content, text: 'boo')]
          @link.valid?.should be_false
          @link.should have(1).error_on(:base)
          @link.contents = [FactoryGirl.build(:georgia_content, text: 'foo/bar')]
          @link.valid?.should be_false
          @link.should have(1).error_on(:base)
        end

      end
    end

  end

end