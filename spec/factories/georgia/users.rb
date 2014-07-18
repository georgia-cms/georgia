FactoryGirl.define do
  factory :georgia_user, class: Georgia::User do
    sequence(:email) {|n| "bob#{n}@example.com"}
    password 'ABCDE12345'
    password_confirmation 'ABCDE12345'

    factory :georgia_admin_user do
      after(:create) do |user|
        user.roles << Georgia::Role.where(name: 'admin').first_or_create
      end
    end
  end
end
