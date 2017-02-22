require 'watir'
time = Time.now.strftime("%d/%m/%Y %H:%M")
browser = Watir::Browser.new :chrome

browser.goto 'http://thehindu.com'
sleep(10)
Breakingnews = browser.div(:class => 'col-xs-12 col-sm-6 col-md-6 col-lg-6 hover-icon').text
File.open("Breakingnews.txt", "w") { |file| file.write( "#{Breakingnews}" "\n" "\n" "The time I updated this is #{time}") }