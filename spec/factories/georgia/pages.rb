FactoryGirl.define do
  factory :georgia_page, class: Georgia::Page do
    sequence(:slug) {|n| "page#{n}"}
    public true
    after(:create) do |page|
      page.current_revision = create(:georgia_revision, revisionable: page)
      page.save!
    end
  end
end