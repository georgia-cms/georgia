FactoryGirl.define do
  factory :georgia_page, class: Georgia::Page do
    sequence(:slug) {|n| "page#{n}"}
    association :current_revision, factory: :revision_with_content
  end
end