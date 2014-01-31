ActsAsTaggableOn::Tag.class_eval do

  include ::Tire::Model::Search
  include ::Tire::Model::Callbacks

  def to_indexed_json
    {name: name}.to_json
  end

end