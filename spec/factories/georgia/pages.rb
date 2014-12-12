FactoryGirl.define do
  factory :georgia_page, class: Georgia::Page do
    sequence(:slug) {|n| "page#{n}"}
    public true
    association :current_revision, factory: :georgia_revision
  end
end