FactoryGirl.define do
  factory :picture, class: Ckeditor::Asset do
    tag_list "tag1, tag2, tag3"
  end
end