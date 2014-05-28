FactoryGirl.define do
  factory :georgia_user, class: Georgia::User do
    sequence(:email) {|n| "bob#{n}@example.com"}
    password 'ABCDE12345'
    password_confirmation 'ABCDE12345'

    factory :georgia_admin_user do
      after(:create) do |user|
        user.role = Georgia::Role.where(name: 'Admin').first_or_create
      end
    end
  end
end
