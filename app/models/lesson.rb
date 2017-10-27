class Lesson < ApplicationRecord
  belongs_to :company

  validates :name, format: { with: /\A[a-zA-Z\d]+\z/, message: "only allows letters and numbers" }
  validates :active, presence: true
end
