class MessagesController < ApplicationController

  # Convenient method to create and check for spam
  def create
    @message = Georgia::Message.new(message_params)
    if @message.valid? and @message.save
      SpamWorker.perform_async(@message.id)
    end
    respond_to do |format|
      # FIXME: Add translated flash message on success and failure
      format.html { redirect_to :back }
      format.js   { render layout: false }
    end
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