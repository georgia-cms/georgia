module Georgia
  class ApplicationDecorator < Draper::Decorator

    delegate_all

    %w(created_at updated_at).each do |timestamp|
      define_method("pretty_#{timestamp}") { model.send(timestamp).strftime('%F') }
    end

    def created_by_name
      return 'unknown' unless model and model.created_by
      "#{model.created_by.name} (#{pretty_created_at})"
    end

    def updated_by_name
      return 'unknown' unless model and model.updated_by
      "#{model.updated_by.name} (#{pretty_updated_at})"
    end

  end
end