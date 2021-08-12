class Event < ApplicationRecord
  validates :start_date, presence: true
  validate :is_after?
  validates :duration, presence: true
  validate :divisible_by_five?
  validates :title, presence: true, length: {in: 5..140}
  validates :description, presence: true, length: {in: 20..1000}
  validates :price, presence: true, numericality: {in: 0..1000}
  validates :location, presence: true
  belongs_to :administrator, class_name: "User"
  has_many :attendances
  has_many :users, through: :attendances

  def is_after?
    self.start_date > DateTime.now
  end

  def divisible_by_five?
    if (self.duration%5) == 0 and self.duration > 0
      return true
    else
      return false
    end
  end
end
