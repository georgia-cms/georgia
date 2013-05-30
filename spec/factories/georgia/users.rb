FactoryGirl.define do
  factory :georgia_user, class: Georgia::User do
    sequence(:email) {|n| "bob#{n}@example.com"}
    password 'ABCDE12345'
    password_confirmation 'ABCDE12345'

    factory :admin do
      roles [FactoryGirl.create(:georgia_role, name: 'Admin')]
    end
    factory :editor do
      roles [FactoryGirl.create(:georgia_role, name: 'Editor')]
    end

  end
end
