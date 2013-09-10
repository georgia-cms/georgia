class MessagesController < ApplicationController

  # Convenient method to create and check for spam
  # Requires main application to have a messages/create.js.erb template and the form to be set remote: true
  # FIXME: Should handle multiple response formats and provides default templates
  def create
    @message = Georgia::Message.new(params[:message])
    @message.referrer = request.referrer
    @message.user_ip = request.remote_ip
    @message.user_agent = request.user_agent
    if @message.valid?
      SpamWorker.perform_async(@message.id) if @message.save
    end
    render layout: false
  end
end