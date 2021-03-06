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
      user.roles << Georgia::Role.where(name: 'admin').first!
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

  namespace :elasticsearch do

    desc 'Setup ElasticSearch indices'
    task setup: :environment do

      Georgia::Page.__elasticsearch__.client.indices.delete index: Georgia::Page.index_name rescue nil
      Georgia::Page.__elasticsearch__.create_index! force: true
      Georgia::Page.import

      Ckeditor::Asset.__elasticsearch__.client.indices.delete index: Ckeditor::Asset.index_name rescue nil
      Ckeditor::Asset.__elasticsearch__.create_index! force: true
      Ckeditor::Asset.import
      Ckeditor::Picture.import
      Ckeditor::AttachmentFile.import

      ActsAsTaggableOn::Tag.__elasticsearch__.client.indices.delete index: ActsAsTaggableOn::Tag.index_name rescue nil
      ActsAsTaggableOn::Tag.__elasticsearch__.create_index! force: true
      ActsAsTaggableOn::Tag.import
    end

  end

  namespace :ckeditor do
    desc 'Create nondigest versions of some ckeditor assets (e.g. moono skin png)'
    task :create_nondigest_assets do
      fingerprint = /\-[0-9a-f]{32}\./
      for file in Dir['public/assets/ckeditor/contents-*.css', 'public/assets/ckeditor/skins/moono/*.png']
        next unless file =~ fingerprint
        nondigest = file.sub fingerprint, '.' # contents-0d8ffa186a00f5063461bc0ba0d96087.css => contents.css
        FileUtils.cp file, nondigest, verbose: true
      end
    end
  end

end