require 'spec_helper'

describe Georgia::Page do

  specify {FactoryGirl.build(:georgia_page).should be_valid}

  it_behaves_like 'a taggable model'
  it_behaves_like 'a orderable model'
  it_behaves_like 'a previewable model'
  it_behaves_like 'a slugable model'
  it_behaves_like 'a revisionable model'
  it_behaves_like 'a indexable model'
  it_behaves_like 'a copyable model'
  it_behaves_like 'a treeable model'

  describe 'scopes' do
    describe '.not_self' do
      it "does not return itself" do
        @page = FactoryGirl.create(:georgia_page)
        expect(Georgia::Page.not_self(@page)).not_to include @page
      end
    end
  end

end