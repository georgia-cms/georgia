FactoryGirl.define do
  factory :georgia_revision, class: Georgia::Revision do
    template 'one-column'
    state 'revision'

    factory :georgia_review do
      state 'review'
    end
    factory :georgia_draft do
      state 'draft'
    end
    factory :georgia_published do
      state 'published'
      factory :revision_with_content do
        after(:create) do |revision|
          create(:georgia_content, contentable_id: revision.id, contentable_type: 'Georgia::Revision')
        end
      end
    end
  end
end