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

  it_behaves_like 'a statusable model'
  it_behaves_like 'a revisionable model'
  it_behaves_like 'a contentable model'
  it_behaves_like 'a searchable model'
  it_behaves_like 'a taggable model'
  it_behaves_like 'a slugable model'
  it_behaves_like 'a templatable model'
  it_behaves_like 'a orderable model'

  describe 'scopes' do
    describe '.not_self' do
      it "does not return itself" do
        @page = FactoryGirl.create(:georgia_page)
        expect(Georgia::Page.not_self(@page)).not_to include @page
      end
    end
  end
    describe  '#url' do

    context 'with only one locale' do

      it 'returns a relative path' do
        page = FactoryGirl.build(:georgia_page, slug: 'relative')
        page.url.should match '/relative'
      end

      context 'with ancestry' do

        it 'prepends the ancestors slugs' do
          root = FactoryGirl.create(:georgia_page, slug: 'parent')
          descendant = FactoryGirl.create(:georgia_page, slug: 'kid', parent: root)
          page = FactoryGirl.create(:georgia_page, slug: 'gong', parent: descendant)
          page.url.should match '/parent/kid/gong'
        end

      end

    end

    context 'with multiple available locales' do

      before :each do
        I18n.available_locales = [:en, :fr]
        I18n.locale = :en
      end

      it 'prepends the current locale' do
        page = FactoryGirl.build(:georgia_page, slug: 'with-locale')
        page.url.should match '/en/with-locale'
      end

      context 'with ancestry' do

        it 'prepends the current locale followed by ancestors slugs' do
          root = FactoryGirl.create(:georgia_page, slug: 'foo')
          descendant = FactoryGirl.create(:georgia_page, slug: 'bar', parent: root)
          page = FactoryGirl.create(:georgia_page, slug: 'bang', parent: descendant)
          page.url.should match '/en/foo/bar/bang'
        end

      end

    end
  end

end