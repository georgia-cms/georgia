FactoryGirl.define do
  factory :georgia_page, class: Georgia::Page do
    template 'one-column'
    sequence(:slug) {|n| "page#{n}"}
    association :status, factory: :georgia_status
  end
end