class TagCategory < ApplicationRecord
  include Discard::Model

  validates :name, {presence: true, uniqueness: true, length: {maximum: 30}}
  
  has_many :tags

  def tags
    return Tag.where(tag_category_id: self.id)
  end
end
