class Transaction < ApplicationRecord
  validates :title, presence: true, allow_blank: false
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :recurrence, presence: true, if: :recurring?
  validates :payment_date, presence: true, if: :paid?
  
  enum :status, {pending: 0, paid: 1, overdue: 2}
  enum :recurrence, {daily: 0, weekly: 1, monthly: 2}
  
  before_validation :payment_behaviour
  
  private
  
  def payment_behaviour
    self.payment_date = Date.today if self.paid?
    self.status = :paid if self.payment_date.present?
    self.status = :overdue if self.until_date.present? && self.until_date < Date.today && !self.payment_date.present?
  end
end
