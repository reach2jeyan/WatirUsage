require 'telegram/bot'
contents = File.open("linkedinconnection.txt") {|file| file.read}
scrap = File.open("linkedindatascrap.rb") {|file| file.read}
breakingnews = File.open("Breakingnews.txt") {|file| file.read}


require 'openssl'
   OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
   
token = ''

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/Hey'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}, What can I do for you")
    when '/Anynewconnectionsinlinkedin?'
      bot.api.send_message(chat_id: message.chat.id, text: contents)
    when '/Getmenewsupdate'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}! Here is your breaking news" "\n" "\n" "#{breakingnews}" "\n" "\n" "Would you like to have information on technews or entertainment?")
    end
  end
end

      



