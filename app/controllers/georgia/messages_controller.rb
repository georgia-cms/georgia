module Georgia
  class MessagesController < Georgia::ApplicationController

    load_and_authorize_resource class: 'Georgia::Message'

    helper_method :sort_column, :sort_direction


    def search
      @messages = Message.search(params[:query]).page(params[:page]).decorate
      render 'index'
    end

    def index
      @messages = Message.order(sort_column + ' ' + sort_direction).page(params[:page]).decorate
    end

    def destroy
      @message = Message.find(params[:id])
      @message.destroy

      redirect_to messages_url
    end

    def new
    end

    def edit
      @message = Message.find(params[:id]).decorate
    end

    def create
      @message = Message.new(params[:message])
      if @message.save
        Georgia::Notifier.notify_support(@message).deliver
      end
      render layout: false
    end

    private

    def sort_column
      Message.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end


  end
end