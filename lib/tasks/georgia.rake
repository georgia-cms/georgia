namespace :georgia do

  desc "Creates an Admin user to get started"
  task seed: :environment do
    require "highline/import"

    def create_user
      first_name = ask("First name: ")
      last_name = ask("Last name: ")
      email = ask("Email: ")
      password = ask("Password: ")
      user = Georgia::User.create(first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password) do |user|
        user.roles << Georgia::Role.all
      end
      user
    end

    begin
      user = create_user
      raise 'Invalid user' unless user.valid?
      say(HighLine.color("Admin user successfully created.", :green))
    rescue
      say(HighLine.color("#{user.errors.full_messages.join('. ')}", :red))
      retry
    end
  end

end