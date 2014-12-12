require 'rails_helper'

describe Georgia::Widget, type: :model do

  specify { expect(build(:georgia_widget)).to be_valid }

  it { expect(subject).to have_many(:ui_associations) }
  it { expect(subject).to have_many(:ui_sections) }
  it { expect(subject).to have_many(:revisions) }

  it_behaves_like 'a contentable model'

  describe 'scopes' do

    before :all do
      @footer_widget = create(:georgia_widget)
      @sidebar_widget = create(:georgia_widget)
      @submenu_widget = create(:georgia_widget)
      create(:georgia_ui_association, widget: @footer_widget, ui_section: create(:georgia_ui_section, name: 'Footer'))
      create(:georgia_ui_association, widget: @sidebar_widget, ui_section: create(:georgia_ui_section, name: 'Sidebar'))
      create(:georgia_ui_association, widget: @submenu_widget, ui_section: create(:georgia_ui_section, name: 'Submenu'))
    end

    after :all do
      Georgia::Widget.destroy_all
    end

    describe '.footer' do
      let(:widgets) { Georgia::Widget.footer }

      it 'scopes footer widgets' do
        expect(widgets).to include @footer_widget
        expect(widgets).not_to include @sidebar_widget
        expect(widgets).not_to include @submenu_widget
      end
    end

    describe '.sidebar' do
      let(:widgets) { Georgia::Widget.sidebar }

      it 'scopes sidebar widgets' do
        expect(widgets).not_to include @footer_widget
        expect(widgets).to include @sidebar_widget
        expect(widgets).not_to include @submenu_widget
      end
    end

    describe '.submenu' do
      let(:widgets) { Georgia::Widget.submenu }

      it 'scopes submenu widgets' do
        expect(widgets).not_to include @footer_widget
        expect(widgets).not_to include @sidebar_widget
        expect(widgets).to include @submenu_widget
      end
    end

  end

end