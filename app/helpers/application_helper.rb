module ApplicationHelper

  def current_class? test_path
    request.path == test_path ? :active : nil
  end

  def send_message
    name = ChatWork::Me.get["name"]
    account_id = ChatWork::Me.get["account_id"]
    room_id = ChatWork::Me.get["room_id"]
    message_body = "[To:#{account_id}] #{name} Well done!"
    ChatWork::Message.create room_id: room_id, body: message_body
  end
end
