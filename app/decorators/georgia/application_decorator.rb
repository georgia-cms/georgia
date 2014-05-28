module Georgia
  class ApplicationDecorator < Draper::Decorator
    delegate_all


    def pretty_created_at
      prettify_date(created_at)
    end

    def pretty_updated_at
      prettify_date(updated_at)
    end

    private

    def prettify_date date
      date.is_a?(String) ? date : date.try(:strftime, '%F')
    end

  end
end