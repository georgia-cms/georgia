module Georgia
  class MessagesController < ApplicationController

    load_and_authorize_resource class: Georgia::Message

    before_filter :prepare_search, only: [:search, :show, :spam, :ham]


    def index
      redirect_to action: :search
    end

    def search
    end

    # Destroy multiple assets
    def destroy
      ids = params[:id].split(',')
      if @messages = Message.destroy(ids)
        render layout: false
      else
        head :internal_server_error
      end
    end

    def destroy_all_spam
      if Message.spam.destroy_all
        redirect_to :back, notice: 'All spam messages have been successfully deleted.'
      else
        redirect_to :back, alert: 'Oups. Something went wrong.'
      end
    end

    def show
      @message = Message.find(params[:id]).decorate
    end

    def spam
      @message = Message.find(params[:id])
      if @message.spam!
        @message.update_attribute(:spam, true)
        redirect_to :back, notice: 'Message successfully marked as spam.'
      else
        redirect_to :back, alert: 'Oups. Something went wrong.'
      end
    end

    def ham
      @message = Message.find(params[:id])
      if @message.ham! == false
        @message.update_attribute(:spam, false)
        redirect_to :back, notice: 'Message successfully marked as ham.'
      else
        redirect_to :back, alert: 'Oups. Something went wrong.'
      end
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
