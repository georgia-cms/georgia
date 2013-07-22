FactoryGirl.define do
  factory :georgia_page, class: Georgia::Page do
    template 'one-column'
    sequence(:slug) {|n| "page#{n}"}

    factory :georgia_meta_page, class: Georgia::MetaPage
    factory :georgia_review, class: Georgia::Review
    factory :georgia_draft, class: Georgia::Draft
    factory :georgia_revision, class: Georgia::Revision
  end
end