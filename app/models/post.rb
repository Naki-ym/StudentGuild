class Post < ApplicationRecord
  include Discard::Model

  validates :content, {presence: true, length: {maximum: 200}}
  validates :user_id, {presence: true}

  belongs_to :user
  has_many :favorites

  def user
    return User.kept.find_by(id: self.user_id)
  end
  def favorites
    return Favorite.where(post_id: self.id)
  end
end
