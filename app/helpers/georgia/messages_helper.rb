module Georgia
  module MessagesHelper

    def message_actions_list(message)
      Georgia::MessageActionsPresenter.new(self, message)
    end

  end
end