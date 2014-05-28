require 'spec_helper'

describe Georgia::UiAssociation do

  specify {FactoryGirl.build(:georgia_ui_association).should be_valid}

  it { should belong_to(:revision) }
  it { should belong_to(:widget) }
  it { should belong_to(:ui_section) }

  it { should respond_to :widget_id, :ui_section_id, :page_id }

  it_behaves_like 'a orderable model'

  describe 'validations' do
    it 'validates presence of associated Page' do
      @ui_association = FactoryGirl.build(:georgia_ui_association, page_id: nil)
      @ui_association.valid?.should be_false
      @ui_association.should have(1).errors_on(:base)
      expect(@ui_association.errors_on(:base).first).to eq('An association to a page is required.')
    end
    it 'validates presence of associated UI Section' do
      @ui_association = FactoryGirl.build(:georgia_ui_association, ui_section_id: nil)
      @ui_association.valid?.should be_false
      @ui_association.should have(1).errors_on(:base)
      expect(@ui_association.errors_on(:base).first).to eq('An association to a UI Section is required.')
    end
    it 'validates presence of associated Widget' do
      @ui_association = FactoryGirl.build(:georgia_ui_association, widget_id: nil)
      @ui_association.valid?.should be_false
      @ui_association.should have(1).errors_on(:base)
      expect(@ui_association.errors_on(:base).first).to eq('An association to a Widget is required.')
    end
  end

  describe '.for_revision' do
    it 'returns widgets for a given revision' do
      revision = create(:georgia_revision)
      @ui_assoc = create(:georgia_ui_association, revision: revision)
      expect(Georgia::UiAssociation.for_revision(revision)).to include @ui_assoc
    end
  end

end