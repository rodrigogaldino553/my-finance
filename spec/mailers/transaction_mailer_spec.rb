require "rails_helper"

RSpec.describe TransactionMailer, type: :mailer do
  describe "payment_reminder" do
    let(:transaction) { transactions(:one) }
    let(:mail) { TransactionMailer.payment_reminder(transaction) }

    it "renders the headers" do
      expect(mail.subject).to eq("Upcoming Payment: #{transaction.title}")
      expect(mail.to).to eq([ENV.fetch("NOTIFICATION_EMAIL", "rodrigo@example.com")])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(transaction.title)
      expect(mail.body.encoded).to match(ActiveSupport::NumberHelper.number_to_currency(transaction.amount))
    end
  end
end
