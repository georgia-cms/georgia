module Georgia::Indexer
  class Adapter

    # Delegate search to the model
    def search model, params
      model.search model, params
    end

  end
end