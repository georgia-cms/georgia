FactoryGirl.define do
  factory :georgia_content, class: Georgia::Content do
    locale 'en'
    title 'My title'
    text  'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    excerpt 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    keyword_list 'tag1, tag2, tag3'

    trait :english do
      locale 'en'
    end

    trait :french do
      locale 'fr'
    end
  end
end