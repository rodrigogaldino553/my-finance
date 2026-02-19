# Preview all emails at http://localhost:3000/rails/mailers/transaction_mailer
class TransactionMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/transaction_mailer/payment_reminder
  def payment_reminder
    TransactionMailer.payment_reminder
  end
end
