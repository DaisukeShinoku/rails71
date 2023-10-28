class Team < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
end
