class Message < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 200}}

  belongs_to :room
  belongs_to :user

  def user
    return User.find_by(id: self.user_id, is_deleted: false)
  end
end
