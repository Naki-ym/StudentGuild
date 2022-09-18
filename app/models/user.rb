class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true, length: {maximum: 30}}
  validates :email, {presence: true, uniqueness: true}

  has_many :posts
  has_many :favorites
  has_many :room_users
  has_many :messages
  has_many :projects
  has_many :entries

  def favorited_by?(post_id)
    favorites.where(post_id: post_id, is_deleted: false).exists?
  end
end