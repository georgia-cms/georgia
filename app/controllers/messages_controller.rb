class MessagesController < ApplicationController
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