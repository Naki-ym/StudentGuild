class TagCategory < ApplicationRecord
  validates :name, {presence: true, uniqueness: true, length: {maximum: 30}}
  
  has_many :tags
end
