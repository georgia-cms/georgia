FactoryGirl.define do
  factory :georgia_revision, class: Georgia::Revision do
    template 'one-column'

    factory :georgia_review do
      status 'review'
    end
    factory :georgia_draft do
      status 'draft'
    end
    factory :georgia_published do
      status 'published'
      factory :revision_with_content do
        after(:create) do |revision|
          create(:georgia_content, contentable_id: revision.id, contentable_type: 'Georgia::Revision')
        end
      end
    end
  end
end