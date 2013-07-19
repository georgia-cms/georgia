FactoryGirl.define do
  factory :georgia_page, class: Georgia::Page do
    template 'one-column'
    sequence(:slug) {|n| "page#{n}"}
  end
end