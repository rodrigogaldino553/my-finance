return if Rails.env.test?

# config/initializers/sidekiq.rb
if Rails.env.production? || ENV['REDIS_URL'].present?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
end

# Sidekiq::Cron::Job.create(
#   name: "Payment Notification - Daily",
#   cron: "0 8 * * *", # Daily at 8 AM
#   class: "PaymentNotificationJob"
# )
