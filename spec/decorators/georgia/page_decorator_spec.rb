require 'spec_helper'

describe Georgia::PageDecorator do

  subject {Georgia::PageDecorator.decorate(FactoryGirl.build(:page))}

  it_behaves_like 'a decorator'

  it {should respond_to :excerpt_or_text}
  it {should respond_to :url}
  it {should respond_to :status_tag}
  it {should respond_to :template_path}

  describe '#template_path' do

    it "returns the partial path corresponding to the template" do
      page = Georgia::PageDecorator.decorate(FactoryGirl.build(:page, template: 'contact'))
      page.template_path.should match 'pages/templates/contact'
    end

  end

  describe  '#url' do

    context 'with only one locale' do

      it 'returns a relative path' do
        page = Georgia::PageDecorator.decorate(FactoryGirl.build(:page, slug: 'foo'))
        page.url.should match '/foo'
      end

      context 'with ancestry' do

        it 'prepends the ancestors slugs' do
          root = FactoryGirl.create(:page, slug: 'foo')
          descendant = FactoryGirl.create(:page, slug: 'bar', parent: root)
          page = FactoryGirl.create(:page, slug: 'gong', parent: descendant)
          Georgia::PageDecorator.decorate(page).url.should match '/foo/bar/gong'
        end

      end

    end

    context 'with multiple available locales' do

      before :each do
        I18n.available_locales = [:en, :fr]
        I18n.locale = :en
      end

      it 'prepends the current locale' do
        page = Georgia::PageDecorator.decorate(FactoryGirl.build(:page, slug: 'foo'))
        page.url.should match '/en/foo'
      end

      context 'with ancestry' do

        it 'prepends the current locale followed by ancestors slugs' do
          root = FactoryGirl.create(:page, slug: 'foo')
          descendant = FactoryGirl.create(:page, slug: 'bar', parent: root)
          page = FactoryGirl.create(:page, slug: 'gong', parent: descendant)
          Georgia::PageDecorator.decorate(page).url.should match '/en/foo/bar/gong'
        end

      end

    end
  end

  describe '#excerpt_or_text' do

    context 'with an excerpt' do

      it 'returns #excerpt' do
        page = Georgia::PageDecorator.decorate(FactoryGirl.build(:page))
        page.contents << FactoryGirl.build(:content, text: nil)
        page.excerpt_or_text.should match page.contents.first.excerpt
      end

    end

    context 'without an excerpt' do

      it 'truncates #text' do
        page = Georgia::PageDecorator.decorate(FactoryGirl.build(:page))
        page.contents << FactoryGirl.build(:content, excerpt: nil)
        page.contents.first.text.should match /^#{page.excerpt_or_text}.*/
      end

    end

    context 'without an excerpt or text' do

      it 'returns nil' do
        page = Georgia::PageDecorator.decorate(FactoryGirl.build(:page))
        page.contents << FactoryGirl.build(:content, text: nil, excerpt: nil)
        page.excerpt_or_text.should be_nil
      end

    end

  end

  describe '#status_tag' do
    it 'should be done with state_machine'
  end

end