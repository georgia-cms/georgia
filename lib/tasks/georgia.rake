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

end