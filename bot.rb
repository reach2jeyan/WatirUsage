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
      question = 'Which news' "\n" "\n" '1.General , 2. Tech, 3.Entertainment, 4. Weather'
      answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(1 2), %w(3 4)], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: answers)
      if answers.include? '1'
        bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}, Great")
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}, Too bad")
      end
    end
  end
end

  




       



      



