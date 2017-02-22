require 'watir'
require 'rufus-scheduler'

time = Time.now.strftime("%d/%m/%Y %H:%M")

require 'tzinfo/data'

ENV['TZ'] = 'Asia/Kolkata'

scheduler = Rufus::Scheduler.new


scheduler.every '15m' do
    system("ruby bot.rb")
    puts "Server On"
end

scheduler.every '20m' do
    puts "Cron job update in process. Please wait..."
    puts time
    system("ruby linkedindatascrap.rb")
end

scheduler.join

