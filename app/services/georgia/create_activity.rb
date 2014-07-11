module Georgia
  class CreateActivity

    def initialize object, action, options={}
      @object  = object
      @action  = action
      @options = options
    end

    def call
      @object.create_activity @action, @options
      # push to websocket to display on Dashboard
    end

  end
end