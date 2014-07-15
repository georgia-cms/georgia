ActsAsTaggableOn.remove_unused_tags = true
ActsAsTaggableOn::Tag.send(:include, Elasticsearch::Model)
ActsAsTaggableOn::Tag.send(:include, Elasticsearch::Model::Callbacks)
ActsAsTaggableOn::Tag.class_eval do
  def self.policy_class
    Georgia::ApiPolicy
  end
end