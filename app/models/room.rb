class Room < ApplicationRecord
  validates :name, {presence: true, length: {maximum: 30}}
  validates :caption, {presence: true}

  has_many :room_users
  has_many :messages
end
