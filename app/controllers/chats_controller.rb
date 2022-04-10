class ChatsController < ApplicationController
  def top
    @room_users = RoomUser.where(user_id: @current_user.id, is_deleted: false)
    @rooms = []
    @room_users.each do |room_user|
      @room = Room.find_by(id: room_user.room_id, is_deleted: false)
      @rooms << @room
    end
  end
  def create
    @room = Room.new
    @myroomusers = RoomUser.where(user_id: @current_user.id, is_deleted: false)
    @rooms = []
    @roomusers = []
    @users = []
    @myroomusers.each do |myroomuser|
      @myroom = Room.find_by(id: myroomuser.room_id, is_group_chat: false, is_deleted: false)
      @rooms << @myroom
    end
    @rooms.each do |room|
      @roomuser = RoomUser.where.not(user_id: @current_user.id).find_by(room_id: room.id, is_deleted: false)
      @roomusers << @roomuser
    end
    @roomusers.each do |roomuser|
      @user = User.find_by(id: roomuser.user_id)
      @users << @user
    end
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
  def create_group
    @room = Room.new(name: params[:name], caption: params[:caption], is_group_chat: true)
    unless @room.save
      render("chats/create")
      exit
    end
    @members = [@current_user, @user]
    @members.each do |member|
      @room_user = RoomUser.new(room_id: @room.id, user_id: member.id)
      unless @room_user.save
        render("chats/create")
      end
    end
    redirect_to("/chats/#{@room.id}")
  end
  def crate_individual
    @user = User.find_by(id: params[:id], is_deleted: false)
    @room = Room.new(name: "#{@user.name}&#{@current_user.name}", caption: "#{@user.name}さんと#{@current_user}さんでの個人チャット", is_group_chat: false)
    unless @room.save
      render("users/show")
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
