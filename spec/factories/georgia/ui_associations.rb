FactoryGirl.define do
  factory :georgia_ui_association, class: Georgia::UiAssociation do
    association :page, factory: :georgia_page
    association :widget, factory: :georgia_widget
    association :ui_section, factory: :georgia_ui_section
  end
end