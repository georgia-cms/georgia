namespace :sidekiq do

  desc "Clear Sidekiq Retry Queue"
  task clear_queue: :environment do
    Sidekiq::RetrySet.new.clear
  end

end