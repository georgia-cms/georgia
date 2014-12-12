require 'rails_helper'

describe Georgia::PageDecorator do

  subject {Georgia::PageDecorator.decorate(FactoryGirl.build(:georgia_page))}

  it { expect(subject).to respond_to :excerpt_or_text }
  it { expect(subject).to respond_to :url }
  it { expect(subject).to respond_to :status_tag }
  it { expect(subject).to respond_to :template_path }

  describe '#template_path' do

    it "returns the partial path corresponding to the template" do
      page = Georgia::PageDecorator.decorate(build(:georgia_page))
      page.current_revision = build(:georgia_revision, template: 'contact')
      expect(page.template_path).to match 'pages/templates/contact'
    end

  end

end