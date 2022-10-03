class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true, length: {maximum: 30}}
  validates :email, {presence: true}

  has_many :posts
  has_many :favorites
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages
  has_many :projects
  has_many :entries

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  mount_uploader :icon, IconUploader

  #いいねされている？
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

  def followings
    return self.following_user
  end

  #管理者アカウントならtrue
  def admin?
    if self.admin == true
      return true
    end
  end

  #所属している全ての個人チャットを返す
  def joinning_individual_rooms
    rooms = self.rooms.where(is_group_chat: false)
    return rooms
  end

  def connected?(current_user)
    #所属の部屋を取得
    rooms = self.rooms.where(is_group_chat: false)
    user_ids = []
    #所属しているチャットの相手のidを取得して配列へ
    rooms.each do |room|
      users = room.joinning_members
      users.each do |user|
        if user.id != self.id
          user_ids << user.id
        end
      end
    end
    #そこに自分がいればtrueを返す
    if user_ids.include?(current_user.id)
      true
    end
  end

  #その相手と個人チャットしているときそのidを返す
  def connected_individual_room(current_user)
    #所属の部屋を取得
    user_rooms         = self.rooms.where(is_group_chat: false)
    current_user_rooms = current_user.rooms.where(is_group_chat: false)
    room = user_rooms & current_user_rooms
    return room
  end
end