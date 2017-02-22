require 'watir'


time = Time.now.strftime("%d/%m/%Y %H:%M")

friends = "You have 699 connections. Stay up to date with your network"   #Currently harccded. Should make this code more mature to hold the latest update from linkedin and compare it to next result.

browser = Watir::Browser.new :chrome

browser.goto 'http://www.linkedin.com'

browser.input(:id =>'login-email').click
browser.send_keys('')
  
browser.input(:id =>'login-password').click
browser.send_keys('')

browser.button(:id => 'login-submit').click



sleep(10)

browser.element(:id => 'nav-link-network').click

browser.link(:text => 'Connections').click

connections = browser.div(:class =>'content-wrapper').text

browser.element(:xpath => '//*[@id="contact-list-organizer-menu"]/li[2]/dl/dd/div/ul/li/div/ul/li[2]/label')

newfriends = browser.ul(:class => 'items contacts-list-view').text

if connections == friends
    
    File.open("linkedinconnection.txt", "w") { |file| file.write("You have no new connections added") }
    
 else
    File.open("linkedinconnection.txt", "w") { |file| file.write("You have new connections, And the new connections are #{newfriends}") }
    
    
 end


