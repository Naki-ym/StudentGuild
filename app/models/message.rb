class Message < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 200}}

  belongs_to :room
  belongs_to :user
end
