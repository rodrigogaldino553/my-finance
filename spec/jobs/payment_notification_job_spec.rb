require "rails_helper"

RSpec.describe PaymentNotificationJob, type: :job do
  include ActiveJob::TestHelper

  describe "#perform" do
    it "enqueues payment reminder emails for upcoming recurring transactions" do
      # Ensure we have a transaction due tomorrow (setup in fixtures)

      expect {
        perform_enqueued_jobs { PaymentNotificationJob.perform_now }
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      email = ActionMailer::Base.deliveries.last
      expect(email.subject).to include("Upcoming Payment")
    end
  end
end
