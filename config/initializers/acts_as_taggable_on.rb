ActsAsTaggableOn.remove_unused_tags = true
ActsAsTaggableOn::Tag.send(:include, Elasticsearch::Model)
ActsAsTaggableOn::Tag.send(:include, Elasticsearch::Model::Callbacks)