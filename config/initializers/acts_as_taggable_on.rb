# If you would like to remove unused tag objects after removing taggings, add
ActsAsTaggableOn.remove_unused_tags = true

# ActsAsTaggableOn.delimiter = ','

# If you want force tags to be saved downcased:
# ActsAsTaggableOn.force_lowercase = true

# If you want tags to be saved parametrized (you can redefine to_param as well):
# ActsAsTaggableOn.force_parameterize = true

# If you would like tags to be case-sensitive and not use LIKE queries for creation:
# ActsAsTaggableOn.strict_case_match = true

ActsAsTaggableOn::Tag.class_eval do
  searchable do
    text :name
  end
end