class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :name, presence: true, length: { in: 1..50 }
end
