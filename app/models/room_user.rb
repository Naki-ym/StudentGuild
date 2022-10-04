class RoomUser < ApplicationRecord
  include Discard::Model

  belongs_to :room
  belongs_to :user
end
