require 'spec_helper'

describe Georgia::PageDecorator do

  subject {Georgia::PageDecorator.decorate(FactoryGirl.build(:georgia_page))}

  it_behaves_like 'a decorator'

  it {should respond_to :excerpt_or_text}
  it {should respond_to :url}
  it {should respond_to :status_tag}
  it {should respond_to :template_path}

  describe '#template_path' do

    it "returns the partial path corresponding to the template" do
      page = Georgia::PageDecorator.decorate(FactoryGirl.build(:georgia_page, template: 'contact'))
      page.template_path.should match 'pages/templates/contact'
    end

  end

  describe '#excerpt_or_text' do

    context 'with an excerpt' do

      it 'returns #excerpt' do
        page = Georgia::PageDecorator.decorate(FactoryGirl.build(:georgia_page))
        page.contents << FactoryGirl.build(:georgia_content, text: nil)
        page.excerpt_or_text.should match page.contents.first.excerpt
      end

    end

    context 'without an excerpt' do

      it 'truncates #text' do
        page = Georgia::PageDecorator.decorate(FactoryGirl.build(:georgia_page))
        page.contents << FactoryGirl.build(:georgia_content, excerpt: nil)
        page.contents.first.text.should match /^#{page.excerpt_or_text}.*/
      end

    end

    context 'without an excerpt or text' do

      it 'returns nil' do
        page = Georgia::PageDecorator.decorate(FactoryGirl.build(:georgia_page))
        page.contents << FactoryGirl.build(:georgia_content, text: nil, excerpt: nil)
        page.excerpt_or_text.should be_nil
      end

    end

  end

  describe '#status_tag' do
    it 'should be done with state_machine'
  end

end