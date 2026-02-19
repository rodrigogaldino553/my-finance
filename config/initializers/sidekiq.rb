return if Rails.env.test?

Sidekiq::Cron::Job.create(
  name: "Payment Notification - Daily",
  cron: "0 8 * * *", # Daily at 8 AM
  class: "PaymentNotificationJob"
)
