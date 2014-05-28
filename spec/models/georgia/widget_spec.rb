require 'spec_helper'

describe Georgia::Widget do

  specify { build(:georgia_widget).should be_valid }

  it { should have_many(:ui_associations) }
  it { should have_many(:ui_sections) }
  it { should have_many(:revisions) }

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

    describe '.footer' do
      subject { Georgia::Widget.footer }
      it {should include @footer_widget}
      it {should_not include @sidebar_widget}
      it {should_not include @submenu_widget}
    end

    describe '.sidebar' do
      subject { Georgia::Widget.sidebar }
      it {should include @sidebar_widget}
      it {should_not include @footer_widget}
      it {should_not include @submenu_widget}
    end

    describe '.submenu' do
      subject { Georgia::Widget.submenu }
      it {should include @submenu_widget}
      it {should_not include @footer_widget}
      it {should_not include @sidebar_widget}
    end
  end

end