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

    def notify_admins(message, url)
      @message = message
      @url = url
      domain_name = Rails.application.config.action_mailer.smtp_settings[:domain]
      emails_to = (Rails.env.development? ? 'mathieu@motioneleven.com' : Georgia::User.admins.map(&:email))
      mail(
        from: "do-not-reply@#{domain_name}",
        to: emails_to,
        subject: @message
      )
    end

  end
end
