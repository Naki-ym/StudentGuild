module ChatsHelper
  def get_newest_message(room_id)
    newest_message = Message.kept.order(id: :desc).find_by(room_id: room_id)
    if newest_message
      content = newest_message.content
      return content
    else
      return ""
    end
  end
end
