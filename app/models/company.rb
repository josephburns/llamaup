class Company < ApplicationRecord
  validates :name, presence: true
  validates :plan_level, inclusion: { in: ['legacy', 'custom', 'basic', 'plus', 'growth', 'enterprise'] }
end
