module Georgia
  class Notifier < ActionMailer::Base

    include SendGrid

    def notify_support(message)
      @message = message
      mail(
        from: "#{@message.name} <#{@message.email}>",
        to: 'support@motioneleven.com',
        cc: @message.email,
        subject: @message.subject)
    end

  end
end