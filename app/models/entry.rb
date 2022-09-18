class Entry < ApplicationRecord
  validates :user_id, {presence: true}
  validates :project_id, {presence: true}
  validates :content, {presence: true}

  belongs_to :user
  belongs_to :project

  def user
    return User.find_by(id: self.user_id, is_deleted: false)
  end
end
