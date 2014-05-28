module Georgia
  class Presenter

    attr_reader :view_context

    def initialize *args
      @view_context = args.first
    end

    private

    def method_missing(*args, &block)
      view_context.send(*args, &block)
    end

  end
end