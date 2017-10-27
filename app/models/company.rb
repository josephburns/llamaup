class Company < ApplicationRecord
  validates :name, presence: true, length: {minimum: 2, maximum: 255}
  validates :plan_level, inclusion: { in: ['legacy', 'custom', 'basic', 'plus', 'growth', 'enterprise'] }

  TRIAL_PERIOD_DAYS = 30

  def trial_status
    (created_at + TRIAL_PERIOD_DAYS.days) > Date.today
  end
end
