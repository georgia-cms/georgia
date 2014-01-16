FactoryGirl.define do
  factory :georgia_slide, class: Georgia::Slide do
    association :revision, factory: :georgia_revision
  end
end