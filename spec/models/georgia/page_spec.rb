require 'spec_helper'

describe Georgia::Page do

  specify {FactoryGirl.build(:georgia_page).should be_valid}

  it {should have_many(:slides)}
  it {should have_many(:widgets)}
  it {should belong_to(:created_by)}
  it {should belong_to(:updated_by)}

  it {should allow_value('one-column').for(:template)}
  it {should allow_value('sidebar-left').for(:template)}
  it {should allow_value('sidebar-right').for(:template)}

  it_behaves_like 'a contentable model'
  it_behaves_like 'a searchable model'
  it_behaves_like 'a taggable model'
  it_behaves_like 'a slugable model'
  it_behaves_like 'a templatable model'
  it_behaves_like 'a orderable model'
  it_behaves_like 'a clonable model'

  describe 'scopes' do
    describe '.not_self' do
      it "does not return itself" do
        @page = FactoryGirl.create(:georgia_page)
        expect(Georgia::Page.not_self(@page)).not_to include @page
      end
    end
  end

end