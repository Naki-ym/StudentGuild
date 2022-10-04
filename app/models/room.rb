class Room < ApplicationRecord
  include Discard::Model

  validates :name, {presence: true, length: {maximum: 30}}
  validates :caption, {presence: true}

  has_many :room_users
  has_many :users, through: :room_users
  has_many :messages

  def joinning_members
    return self.users
  end
end
