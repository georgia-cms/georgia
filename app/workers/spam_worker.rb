class SpamWorker
  include Sidekiq::Worker

  def perform(message_id)
    @message = Georgia::Message.find(message_id)
    @message.update_attributes(spam: @message.spam?, verified_at: Time.zone.now)
    # TODO: Move this to a seperate worker, possibly a single bulk daily email
    Notifier.notify_info(@message).deliver
  end


end