module Georgia
  class Notifier < ActionMailer::Base

    def notify_admins(message, url)
      @message = message
      @url = url
      emails_to = Georgia::User.where(roles: ['admin', 'editor']).where(receives_notifications: true).pluck(:email)
      unless emails_to.empty?
        mail(
          from: "notify@georgiacms.org",
          to: emails_to,
          subject: @message
          )
      end
    end

    def notify_editors(message, url)
      @message = message
      @url = url
      emails_to = Georgia::User.where(roles: ['admin', 'editor']).where(receives_notifications: true).pluck(:email)
      unless emails_to.empty?
        mail(
          from: "notify@georgiacms.org",
          to: emails_to,
          subject: @message
          )
      end
    end

  end
end
