class MessagesController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user

  def create
    @msg = Message.new(content: params[:content], room_id: params[:id], user_id: @current_user.id, )
    if @msg.save
      redirect_to("/chats/#{params[:id]}")
    else
      redirect_to("/chats/#{params[:id]}")
    end
  end
end