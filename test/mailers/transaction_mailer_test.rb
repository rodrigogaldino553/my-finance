require "test_helper"

class TransactionMailerTest < ActionMailer::TestCase
  test "payment_reminder" do
    transaction = transactions(:one)
    mail = TransactionMailer.payment_reminder(transaction)

    assert_equal "Upcoming Payment: Internet Bill", mail.subject
    assert_equal [ENV.fetch("NOTIFICATION_EMAIL", "rodrigo@example.com")], mail.to
    assert_match "Internet Bill", mail.body.encoded
    assert_match "$100.00", mail.body.encoded
  end
end
