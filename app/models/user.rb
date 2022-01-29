class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true, length: {maximum: 30}}
  validates :email, {presence: true, uniqueness: true}

  has_many :posts
  has_many :favorites

  def favorited_by?(post_id)
    favorites.where(post_id: post_id, delete_flg: false).exists?
  end
end