require 'watir'

browser = Watir::Browser.new :chrome

browser.goto 'http://thehindu.com'
sleep(10)
Breakingnews = browser.div(:class => 'col-xs-12 col-sm-6 col-md-6 col-lg-6 hover-icon').text
File.open("Breakingnews.txt", "w") { |file| file.write("Hey Emjey! I have a breaking news update for you: #{Breakingnews}") }