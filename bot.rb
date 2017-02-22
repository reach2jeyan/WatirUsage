require 'telegram/bot'
contents = File.open("linkedinconnection.txt") {|file| file.read}
breakingnews = File.open("Breakingnews.txt") {|file| file.read}
Technews = File.open("Technews.txt") {|file| file.read}
EntNews = File.open("Entertainment.txt") {|file| file.read}
frienddetails = File.open("linkedinfriends.txt") {|file| file.read}
require 'openssl'
   OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
token = '376531485:AAEFzrgNQP0PNSSvwec5E1UGg9NVIwp4Bmk'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/Hey'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}, I am bumblebee, I know its too early for learning to wash your dishes, but for now I can help you with" "\n" "\n" "1./MyLinkedIn" "\n" "2./Newsupdate." "\n" "3./JobUpdates" "\n" "Feel free to press these commands, I wont blow up")
    when '/MyLinkedIn'
      bot.api.send_message(chat_id: message.chat.id, text: "Press /Connections to know if you have any new connections or /Invitations if you wanna know, about pending friend requests.")
    when '/Newsupdate'
      question = 'Which news' "\n" "\n" "/General , /Tech, /Entertainment, /Weather"
      answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(/General /Tech), %w(/Entertainment /Weather)], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: answers)
    when '/General'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}! Here is your breaking news" "\n" "\n" "#{breakingnews}" "\n" "\n" "Press /Tech here Technews and /Entertainment for Entertainment news. Wanna know about getting drenched today? Get /Weather")
    when '/Tech'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}! Here is your Tech news" "\n" "\n" "#{Technews}" "\n" "\n" "Press /General here General news and /Entertainment for Entertainment news. Wanna know about getting drenched today? Get /Weather")
    when '/Entertainment'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}! What do you wanna? About /Movieratings or /Gossips or /Actresses")
    when '/Movieratings'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}! There you go" "\n" "\n" "#{EntNews}" "\n" "\n" "Press /Tech here Technews and /Entertainment for Entertainment news. Wanna know about getting drenched today? Get /Weather")
    when '/Mylocation'
      bot.api.send_location(chat_id: message.chat.id, latitude: -37.807416, longitude: 144.985339)
    when 'like the group name?'
      bot.api.send_message(chat_id: message.chat.id, text: "Dont fool around? You?Creator? Boooollsshooooott!. Optimus! Where are you?")
    when '/Weather'
      bot.api.send_message(chat_id: message.chat.id, text: "Damn! Hey! #{message.from.first_name}! This is embarassing me, I cant do this now! You know what! I'll notify yo when I get the power to do this")
    when '/Connections'
      bot.api.send_message(chat_id: message.chat.id, text: "There you go #{message.from.first_name}!" "#{contents}")
    when '/Invitations'
      bot.api.send_message(chat_id: message.chat.id, text: "There you go #{message.from.first_name}!" "#{frienddetails}")
    when '/JobUpdates'
      bot.api.send_message(chat_id: message.chat.id, text: "Hey! #{message.from.first_name}" "Trust me! I help you soon with this.")
    end
  end
end

   
  



