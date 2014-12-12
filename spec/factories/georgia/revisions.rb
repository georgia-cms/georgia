FactoryGirl.define do
  factory :georgia_revision, class: Georgia::Revision do
    template 'default'
    status 'published'
    after(:create) do |revision|
      create(:georgia_content, :english, contentable: revision)
      create(:georgia_content, :french, contentable: revision)
    end

    trait :review do
      status 'review'
    end

    trait :draft do
      status 'draft'
    end

    trait :published do
      status 'published'
    end

  end
end