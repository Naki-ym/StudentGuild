class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :post
end
