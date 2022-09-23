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

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  mount_uploader :icon, IconUploader

  def favorited_by?(post_id)
    favorites.where(post_id: post_id, is_deleted: false).exists?
  end

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end