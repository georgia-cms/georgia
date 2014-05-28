module Georgia
  class Policy

    attr_reader :controller

    def initialize *args
      @controller = args.first
    end

    private

    def method_missing(*args, &block)
      controller.send(*args, &block)
    end

  end
end