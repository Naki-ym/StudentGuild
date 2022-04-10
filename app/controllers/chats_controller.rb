class ChatsController < ApplicationController
  def top
    @room_users = RoomUser.where(user_id: @current_user.id, is_deleted: false)
    @rooms = []
    @room_users.each do |room_user|
      @room = Room.find_by(id: room_user.room_id, is_deleted: false)
      @rooms << @room
    end
  end
  def new
    @room = Room.new
  end
  def room
    @current_room = Room.find_by(id: params[:id], is_deleted: false)
    @room_users = RoomUser.where(user_id: @current_user.id, is_deleted: false)
    @rooms = []
    @room_users.each do |room_user|
      @room = Room.find_by(id: room_user.room_id, is_deleted: false)
      @rooms << @room
    end
    @messages = Message.where(room_id: params[:id], is_deleted: false)
  end
  def edit
  end
  def create
  end
  def crate_individual
    @user = User.find_by(id: params[:id], is_deleted: false)
    @room = Room.new(name: "#{@user.name}&#{@current_user.name}", caption: "#{@user.name}さんと#{@current_user}さんでの個人チャット", is_group_chat: false)
    unless @room.save
      render("users/#{@user.id}")
      exit
    end
    @members = [@current_user, @user]
    @members.each do |member|
      @room_user = RoomUser.new(room_id: @room.id, user_id: member.id)
      unless @room_user.save
        render("users/show")
      end 
    end
    redirect_to("/chats/#{@room.id}")
  end
  def update
  end
  def delete
  end
end
