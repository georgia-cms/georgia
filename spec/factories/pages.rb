FactoryGirl.define do
  factory :page, class: Georgia::Page do
    template 'one-column'
    sequence(:slug) {|n| "page#{n}"}
    position 1
    status
  end
end