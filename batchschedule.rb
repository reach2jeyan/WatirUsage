require 'rufus-scheduler'
require 'slack-notifier'
require 'tzinfo/data'
notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
ENV['TZ'] = 'Asia/Kolkata'
scheduler = Rufus::Scheduler.new
scheduler.every '4h' do
  @time = Time.now.strftime("%d/%m/%Y %H:%M")
  #notifier.ping "<@vpandian> <@mrityunjeyan>"".""Scheduled device check initiated at #{@time}. Other Events has been logged at Logchecker"
  $filename = (0...8).map { (65 + rand(26)).chr }.join
  @udid = ['EB9C6F7B-6D8B-42FB-B7F6-5DE776EC88D4','ED24EF06-0CD3-400A-A031-DAE4F4542DD4', 'A8694369-0D7D-4637-B89B-E0C70A9913BA', '3D828A1F-A50E-45F3-A8EB-8DC63F0DEF3C', '55073148-8121-48F2-B085-6E87E0BAA3EA','032E4418-B1DB-4005-A3F4-89CDDE0B5630']
  #@screenstatus = %x[adb shell dumpsys activity activities | grep mFocusedActivity | cut -d . -f 5 | cut -d ' ' -f 1]
  devices = %x[xcrun simctl list devices | grep 'Booted']
  @udid.each do |devicestatus|
    #@screenstatus = %x[adb -s #{devicestatus} shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp' | cut -d . -f 5 | cut -d ' ' -f 1]
    file = File.open("logs.txt", "a+") { |file| file.write( "\n" "Time checked #{@time}" "\t" "#{devicestatus} checked") }
    if devices.include?(devicestatus)
      puts "#{devicestatus} Looks good!"
       file = File.open("connecteddevices.txt", "a+") { |file| file.write( "\n" "Time checked #{@time}" "\t" "#{devicestatus} connected") }
    # elsif @screenstatus.size == 0
    #   a_bad_note = {
    #       fallback: "NEEDS ATTENTION",
    #       text: "#{devicestatus} not attached. Please look into this ASAP <@vpandian> <@mrityunjeyan>",
    #       color: "danger"
    #   }
    #   notifier.ping attachments: [a_bad_note]
    else
       file = File.open("connecteddevices.txt", "a+") { |file| file.write( "\n" "Time checked #{@time}" "\t" "#{devicestatus} needs attention") }
      # system("adb -s #{devicestatus} shell input keyevent 3")
      puts "#{devicestatus} <@vpandian> <@mrityunjeyan> Needs attention!"
    end
  end
end



scheduler.every '24h' do
  puts "Report sent to slack"
  @deviceinfo = File.open("connecteddevices.txt") {|file| file.read}
  @scheduledchecks = File.open("logs.txt") {|file| file.read}
  devicecheckstatus = @deviceinfo.split.count('attention')
  scheduledcheckcount = @scheduledchecks.split.count('checked')
  if devicecheckstatus > 0
    a_repaired_note = {
        fallback: "Device 1pm daily check report.",
        pretext: "iOS simulator checks occurred #{scheduledcheckcount/5

        } times today.Detailed logs available in the server machine",
        text: "<@vpandian> <@mrityunjeyan> , The devices went down #{devicecheckstatus} times",
        color: "warning"
    }
    notifier.ping attachments: [a_repaired_note]
  else
    a_ok_note = {
        fallback: "Device 1pm daily check report",
        pretext: "iOS simulator checks occurred #{scheduledcheckcount/4} times today. Detailed logs available in server machine",
        text: "<@vpandian> <@mrityunjeyan> NO devices went down today",
        color: "good"
    }
    notifier.ping attachments: [a_ok_note]
  end
  
end



scheduler.every '25h' do
  IO.copy_stream('logs.txt', 'logbackup.txt')
  IO.copy_stream('connecteddevices.txt', 'connecteddevicesbackup.txt')
  File.open('logs.txt', 'w') {|file| file.truncate(0) }
  File.open('connecteddevices.txt', 'w') {|file| file.truncate(0) }
end
scheduler.join
