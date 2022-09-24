class MessagesController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user

  def create
    @msg = Message.new(content: params[:content], room_id: params[:id], user_id: @current_user.id, )
    if @msg.save
      redirect_to("/chats/#{params[:id]}")
    else
      # @current_room = Room.find_by(id: params[:id], is_deleted: false)
      # @room_users = RoomUser.where(user_id: @current_user.id, is_deleted: false)
      # @rooms = []
      # @room_users.each do |room_user|
      #   @room = Room.find_by(id: room_user.room_id, is_deleted: false)
      #   @rooms << @room
      # end
      # render("chats/room")
      redirect_to("/chats/#{params[:id]}")
    end
  end
end