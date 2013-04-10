FactoryGirl.define do
  factory :georgia_slide, class: Georgia::Slide do
    association :page, factory: :georgia_page
  end
end