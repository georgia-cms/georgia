require 'spec_helper'

describe Georgia::PageDecorator do

  subject {Georgia::PageDecorator.decorate(FactoryGirl.build(:georgia_page))}

  it {should respond_to :excerpt_or_text}
  it {should respond_to :url}
  it {should respond_to :status_tag}
  it {should respond_to :template_path}

  describe '#template_path' do

    it "returns the partial path corresponding to the template" do
      page = Georgia::PageDecorator.decorate(build(:georgia_page))
      page.current_revision = build(:georgia_revision, template: 'contact')
      page.template_path.should match 'pages/templates/contact'
    end

  end

end