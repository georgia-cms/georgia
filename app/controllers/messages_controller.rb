class MessagesController < ApplicationController

  # Convenient method to create and check for spam
  # Requires main application to have a messages/create.js.erb template and the form to be set remote: true
  # FIXME: Should handle multiple response formats and provides default templates
  def create
    @message = Georgia::Message.new(message_params)
    if @message.valid?
      SpamWorker.perform_async(@message.id) if @message.save
    end
    render layout: false
  end

  private

  def message_params
    @message_params = {}
    params[:message].each do |key, value|
      @message_params[key] = value.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    end
    @message_params[:referrer] = request.referrer
    @message_params[:user_ip] = request.remote_ip
    @message_params[:user_agent] = request.user_agent
    @message_params
  end

end