class MultipleModels < Array
  def client
    Elasticsearch::Model.client
  end

  def ancestors
    []
  end

  def default_per_page
    10
  end

  def inspect
    "MultipleModels: #{super}"
  end
end

module Elasticsearch::Model
  # Search multiple models
  #
  def search(query_or_payload, models=[], options={})
    if models.empty?
      models = Object.constants
      .select { |c| Kernel.const_get(c).respond_to?(:__elasticsearch__) }
      .map    { |c| c.is_a?(Class) ? c : Kernel.const_get(c) }
    end

    models = MultipleModels.new(models)

    index_names    = models.map { |c| c.index_name }
    document_types = models.map { |c| c.document_type }

    search = Searching::SearchRequest.new(
                 models,
                 query_or_payload,
                 {index: index_names, type: document_types}.merge(options)
               )

    Response::Response.new(models, search)
  end

  module_function :search
end