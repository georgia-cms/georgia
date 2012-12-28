# If you would like to remove unused tag objects after removing taggings, add
ActsAsTaggableOn.remove_unused_tags = true

# If you want force tags to be saved downcased:
# ActsAsTaggableOn.force_lowercase = true

# If you want tags to be saved parametrized (you can redefine to_param as well):
# ActsAsTaggableOn.force_parameterize = true

# If you would like tags to be case-sensitive and not use LIKE queries for creation:
# ActsAsTaggableOn.strict_case_match = true

ActsAsTaggableOn::Tag.class_eval do
  include PgSearch
  pg_search_scope :text_search, using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}}, against: :name

  def self.search query
    query.present? ? text_search(query) : scoped
  end
end