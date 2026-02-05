class Transaction < ApplicationRecord
  belongs_to :category
  
  validates :title, presence: true, allow_blank: false
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :recurrence, presence: true, if: :recurring?
  validates :recurring_at, presence: true, if: :recurring?, unless: :new_record?
  validates :payment_date, presence: true, if: :paid?
  validate :recurring_at_less_than_until_date, if: :recurring?
  
  enum :status, {pending: 0, paid: 1, overdue: 2}
  enum :recurrence, {daily: 0, weekly: 1, monthly: 2}
  
  before_validation :payment_behaviour
  after_save do
    next_recurring_transaction if self.recurring? && self.payment_date.present? && self.recurring_at.nil?
  end
  
  private
  
  def next_recurring_transaction
    times = 
      case recurrence
      when "daily"
        ((self.until_date - self.payment_date) / 1.day).truncate
      when "weekly"
        ((self.until_date - self.payment_date) / 1.week).truncate
      when "monthly"
        ((self.until_date - self.payment_date) / 1.month).truncate
      end
    0..times.times.each do |i|
      i = i + 1
      new_transaction = self.dup
      next_time =
        case recurrence
        when "daily"
          self.payment_date + i.days
        when "weekly"
          self.payment_date + i.weeks
        when "monthly"
          self.payment_date + i.months
        end
      new_transaction.payment_date = nil
      new_transaction.recurring_at = next_time
      new_transaction.title = "#{title} - ##{next_time.year}#{next_time.strftime("%b")}"
      new_transaction.status = :pending
      new_transaction.save
    end
    self.update_column(:recurring_at, Time.now)
  end
  
  def recurring_at_less_than_until_date
    errors.add(:recurring_at, "must be less than until_date") if recurring_at && until_date && recurring_at >= until_date
  end
  
  def payment_behaviour
    self.payment_date = Date.today if self.paid?
    self.status = :paid if self.payment_date.present?
    self.status = :overdue if self.until_date.present? && self.until_date < Date.today && !self.payment_date.present?
  end
end
