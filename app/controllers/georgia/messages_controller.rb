module Georgia
  class MessagesController < Georgia::ApplicationController

    load_and_authorize_resource class: 'Georgia::Message'

    helper_method :sort_column, :sort_direction

    def index
      @messages = MessageDecorator.decorate(Message.order(sort_column + ' ' + sort_direction).page(params[:page]))
    end

    def destroy
      @message = Message.find(params[:id])
      @message.destroy

      redirect_to messages_url
    end

    def new
    end

    def create
      @message = Message.new(params[:message])
      @message.created_by_id = current_user.id

      if @message.save
        redirect_to [:new, @message], notice: 'Message was successfully sent.'
      else
        render action: "new"
      end
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