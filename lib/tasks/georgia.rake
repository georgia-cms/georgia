namespace :georgia do

  desc "Creates an Admin user to get started"
  task seed: :environment do
    first_name = ask("First name:")
    last_name = ask("Last name:")
    email = ask("Email:")
    password = ask("Password:")
    Georgia::User.create(first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password) do |user|
      user.roles << Georgia::Role.all
    end
  end

  namespace :messages do

    desc "Send to Akismet all unverified messages"
    task verify: :environment do
      puts "Check for spam. Currently have #{Georgia::Message.spam.count} spam and #{Georgia::Message.ham.count} ham messages."
      puts "Checking #{Georgia::Message.where(verified_at: nil).count} unverified messages."
      Georgia::Message.where(verified_at: nil).find_each do |message|
        message.update_attributes(spam: message.spam?, verified_at: Time.zone.now)
      end
      puts "Check completed. #{Georgia::Message.spam.count} spam. #{Georgia::Message.ham.count} ham."
    end

  end


end