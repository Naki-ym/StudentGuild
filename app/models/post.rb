class Post < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 200}}
  validates :user_id, {presence: true}

  belongs_to :user
  has_many :favorites

  def user
    return User.find_by(id: self.user_id, is_deleted: false)
  end
  def favorites
    return Favorite.where(post_id: self.id, is_deleted: false)
  end
end
