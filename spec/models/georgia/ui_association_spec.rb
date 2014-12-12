require 'rails_helper'

describe Georgia::UiAssociation, type: :model do

  specify {expect(build(:georgia_ui_association)).to be_valid}

  it { expect(subject).to belong_to(:revision) }
  it { expect(subject).to belong_to(:widget) }
  it { expect(subject).to belong_to(:ui_section) }

  it { expect(subject).to respond_to :widget_id, :ui_section_id, :page_id }

  it_behaves_like 'a orderable model'

  describe 'validates' do

    it 'presence of associated Page' do
      @ui_association = build(:georgia_ui_association, page_id: nil)
      expect(@ui_association).not_to be_valid
      expect(@ui_association.errors[:base].length).to be 1
      expect(@ui_association.errors[:base]).to include 'An association to a page is required.'
    end

    it 'presence of associated UI Section' do
      @ui_association = build(:georgia_ui_association, ui_section_id: nil)
      expect(@ui_association).not_to be_valid
      expect(@ui_association.errors[:base].length).to be 1
      expect(@ui_association.errors[:base]).to include 'An association to a UI Section is required.'
    end

    it 'presence of associated Widget' do
      @ui_association = build(:georgia_ui_association, widget_id: nil)
      expect(@ui_association).not_to be_valid
      expect(@ui_association.errors[:base].length).to be 1
      expect(@ui_association.errors[:base]).to include 'An association to a Widget is required.'
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