class User < ApplicationRecord
  belongs_to :circle, required: false

  before_create :set_values

  scope :sent,     -> { where(balance: -5000) }
  scope :received, -> { where(balance: 40000) }
  scope :insiders, -> { where(insider: true) }

  def set_values
    self.name = Faker::Internet.username
    self.insider = true if round < 6
  end
end
