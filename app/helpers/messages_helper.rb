module MessagesHelper
  def user_msg?
    user.id == message.user_id
  end
end
