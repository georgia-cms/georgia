FactoryGirl.define do
  factory :georgia_ui_section, class: Georgia::UiSection do
    sequence(:name) {|n| "UI Section #{n}"}
  end
end