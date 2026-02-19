class PaymentNotificationJob < ApplicationJob
  queue_as :default

  def perform
    # Find pending recurring transactions due tomorrow
    transactions = Transaction.where(status: :pending)
      .where(recurring: true)
      .where(recurring_at: Date.tomorrow.all_day)

    transactions.each do |transaction|
      TransactionMailer.payment_reminder(transaction).deliver_later
    end
  end
end
