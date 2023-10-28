class Player < ApplicationRecord
  belongs_to :team

  validates :name, presence: true, length: { in: 1..50 }
  validates :gender, presence: true

  enum gender: { unknown: 0, male: 1, female: 2 }
end
