FactoryGirl.define do
  factory :georgia_page, class: Georgia::Page do
    template 'one-column'
    sequence(:slug) {|n| "page#{n}"}
    association :current_revision, factory: :georgia_published
  end
end