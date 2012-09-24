FactoryGirl.define do
  factory :user, class: Georgia::User do
    sequence(:email) {"bob#{n}@example.com"}
    password 'ABCDE12345'
    password_confirmation 'ABCDE12345'

    factory :admin do
      roles [FactoryGirl.create(:role, name: 'Admin')]
    end

  end
end
