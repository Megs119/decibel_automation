#Login

require 'selenium-webdriver'
require 'yaml'

#create an object to read yaml file
config_data = YAML.load(File.read('config.yaml'))
yaml_data = YAML.load(File.read('record.yaml'))
env_data = YAML.load(File.binread('environment.yaml'))  
  
#declare data objects
browser_type = config_data['browser']
record_type = config_data['record']
 

  #convert the data string into array
 
  record_arr = record_type.split(",")
  
record_arr.each { |record|
#declare local variables
  username_value = yaml_data[record]['username']
  password_value = yaml_data[record]['password']
  url_value = yaml_data[environment]['url']





driver = Selenium::WebDriver.for :"#{browser_type}"
driver.manage.timeouts.implicit_wait = 10
driver.manage.window.maximize 

driver.get "#{url_value}"

sleep(10) 

username = driver.find_element(:name, "di_e")
username.send_keys(username_value)

password = driver.find_element(:css, "input[name^='di_p']")
password.send_keys(password_value)

sign_in_btn = driver.find_element(:xpath, "//*[@id='loginForm']/div/div[2]/button/span[1]").click

#Validate title of next page
puts driver.title

wait = Selenium::WebDriver::Wait.new(:time =>10)
wait.until {driver.find_element(:xpath, "//img[@src='images/logo.svg?_=5.0.14.11530694687361']")}

#verify logo exists
homepage_logo = driver.find_element(:xpath, "//img[@src='images/logo.svg?_=5.0.14.11530694687361']")



puts driver.title
if driver.title.downcase == "decibel > login"
  puts "Test Case Passed"
else
  raise "Test Case Failed"
end