
#require you selenium-webdriver gem

require 'selenium-webdriver'
require 'yaml'


#create an object to read yaml file
config_data = YAML.load(File.read('C:\Users\Mdevenney\eclipse-workspace\DecibelAutomation\Staging\config.yaml'))
yaml_data = YAML.load(File.read('C:\Users\Mdevenney\eclipse-workspace\DecibelAutomation\Staging\record.yaml'))
  
  
#declare data objects
browser_type = config_data['browser']
record_type = config_data['record']
url_value = config_data['env']  
 

  #convert the data string into array
 
  record_arr = record_type.split(",")
  
record_arr.each { |record|
#declare local variables
  username_value = yaml_data[record]['username']
  password_value = yaml_data[record]['password']
  segment_name_value = yaml_data[record]['segmentname']  
  segment_desc_value = yaml_data[record]['segmentdesc']  
 

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
  
  sleep(5)
  

  segment = driver.find_element(:xpath, "//span[@class='title'][contains(text(),'Segments')]")
  segment.click
  
  wait = Selenium::WebDriver::Wait.new(:time =>10)
  wait.until {driver.find_element(:xpath, "//h1[contains(text(),'Segments')]")}
  
  
  add_segment = driver.find_element(:xpath, "//li[@class='add-segment notindetails']//a[@href='#']//span[@class='menu-item-inactive fill hidden']").click
   
  
  segment_name = driver.find_element(:xpath, "//input[@id='segmentName']")
  segment_name.click
  segment_name.send_keys(segment_name_value)
  
  segment_desc = driver.find_element(:xpath, "//textarea[@name='description']")
  segment_desc.click
  segment_desc.send_keys(segment_desc_value)
  
  add_filters = driver.find_element(:xpath, "//span[contains(text(),'Add filters')]")
  add_filters.click
  
  birdsnest_yes = driver.find_element(:xpath, "//span[contains(text(),'Yes')]")
  birdsnest_yes.click
  
  
  apply_filter = driver.find_element(:xpath, "//span[contains(text(),'Apply this filter')]")
  apply_filter.click

  sleep(5)
  wait.until {driver.find_element(:xpath, "//span[contains(text(),'Save Segment')]")}
 
  
  save_segment = driver.find_element(:xpath, "//span[contains(text(),'Save Segment')]")
  save_segment.click
   
  #segment_exists = driver.find_element(:xpath, "//span[contains(text(), (segment_name_value))]")
  
  #add test cases fail or pass

    
}