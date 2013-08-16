module Georgia
  class MessagesController < Georgia::ApplicationController

    load_and_authorize_resource class: Georgia::Message

    before_filter :prepare_search, only: [:search, :edit]


    def index
      redirect_to action: :search
    end

    def search
    end

    def destroy
      @message = Message.find(params[:id])
      @message.destroy

      redirect_to messages_url
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

    def prepare_search
      @search = Georgia::Message.search do
        fulltext params[:query] do
          fields(:name, :email, :message, :subject, :phone)
        end
        facet :spam
        with(:spam, params[:s]) unless params[:s].blank?
        order_by (params[:o] || :created_at), (params[:dir] || :desc)
        paginate(page: params[:page], per_page: (params[:per] || 25))
      end
      @messages = Georgia::MessageDecorator.decorate_collection(@search.results)
    end

  end
end
