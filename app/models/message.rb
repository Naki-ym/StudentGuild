class Message < ApplicationRecord
  include Discard::Model

  validates :content, {presence: true, length: {maximum: 200}}

  belongs_to :room
  belongs_to :user

  def user
    return User.kept.find_by(id: self.user_id)
  end
end
