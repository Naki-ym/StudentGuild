class Entry < ApplicationRecord
  include Discard::Model

  validates :user_id, {presence: true}
  validates :project_id, {presence: true}
  validates :content, {presence: true}

  belongs_to :user
  belongs_to :project

  def user
    return User.kept.find_by(id: self.user_id)
  end
end
