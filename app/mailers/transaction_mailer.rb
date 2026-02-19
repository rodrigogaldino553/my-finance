class TransactionMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.transaction_mailer.payment_reminder.subject
  #
  def payment_reminder(transaction)
    @transaction = transaction
    mail(to: ENV.fetch("NOTIFICATION_EMAIL", "rodrigo@example.com"), subject: "Upcoming Payment: #{@transaction.title}")
  end
end
