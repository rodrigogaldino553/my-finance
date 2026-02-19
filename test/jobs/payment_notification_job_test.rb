require "test_helper"

class PaymentNotificationJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  test "sends payment reminder for upcoming recurring transactions" do
    assert_enqueued_with(job: SystemJob) do # Sidekiq jobs might wrap in different ways, but let's test mailer enqueue
      # Actually, let's just run the job and check if mail is delivered
      perform_enqueued_jobs do
        PaymentNotificationJob.perform_now
      end
    end

    assert_emails 1

    email = ActionMailer::Base.deliveries.last
    assert_equal "Upcoming Payment: Internet Bill", email.subject
  end
end
