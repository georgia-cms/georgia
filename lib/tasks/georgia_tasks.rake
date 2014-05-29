namespace :georgia do

  desc "Creates an Admin user to get started"
  task seed: :environment do
    require "highline/import"

    class InvalidUser < StandardError; end

    def echo_off
      with_tty do
        system "stty -echo"
      end
    end

    def echo_on
      with_tty do
        system "stty echo"
      end
    end

    def with_tty(&block)
      return unless $stdin.isatty
      begin
        yield
      rescue
        # fails on windows
      end
    end

    def ask_for_password message
      print message
      echo_off
      password = $stdin.gets.to_s.strip
      puts
      echo_on
      password
    end

    def user_instance
      first_name = ask("First name: ")
      last_name = ask("Last name: ")
      email = ask("Email: ")
      password = ask_for_password("Password (typing will be hidden): ")

      user = Georgia::User.new(
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password,
        password_confirmation: password)
      user.role = Georgia::Role.first
      user
    end

    begin
      user = user_instance
      raise InvalidUser, "#{user.errors.full_messages.join('. ')}" unless user.valid?
      say(HighLine.color("Admin user successfully created.", :green)) if user.save
    rescue InvalidUser => ex
      say(HighLine.color(ex.message, :red))
      retry
    end
  end

  desc 'Setup ElasticSearch indices'
  task create_indices: :environment do
    Georgia::Page.__elasticsearch__.create_index! force: true
    Georgia::Page.import
    Ckeditor::Asset.__elasticsearch__.create_index! force: true
    Ckeditor::Asset.import
    ActsAsTaggableOn::Tag.__elasticsearch__.create_index! force: true
    ActsAsTaggableOn::Tag.import
  end

end