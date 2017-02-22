require 'watir'
require 'rufus-scheduler'
require 'telegram/bot'
time = Time.now.strftime("%d/%m/%Y %H:%M")
require 'tzinfo/data'
ENV['TZ'] = 'Asia/Kolkata'
scheduler = Rufus::Scheduler.new
scheduler.every '25m' do   #Since the server need to be run every time, to fetch the new update. Hence, a cron job. Need to find a code that would kill the job before activating another
    system("ruby bot.rb")
    puts "Cron job running. Started at #{time}"
end
scheduler.every '45m' do  #Cron job that would fetch me the results, So what ever you code with watir and place it, you schedule that file to run here.
    puts "Cron job update in process. Please wait..."
    puts time
    system("ruby linkedindatascrap.rb")
end
scheduler.every '10m' do
    puts "Cron job update happening.."
    puts time
    system("ruby newsbot.rb")
end
scheduler.join

