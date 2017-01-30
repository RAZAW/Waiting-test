#filename: waiting.rb

#filename: waiting.rb

require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers

def setup
	@driver = Selenium::WebDriver.for :firefox
	#@driver.manage.timeouts.implicit_wait = 3
end

def teardown
	@driver.quit
end

def run
	setup
	yield
	teardown
end

def wait_for(seconds)
	Selenium::WebDriver::Wait.new(timeout: seconds).until {yield}
end


run do
	@driver.get 'http://the-internet.herokuapp.com/dynamic_loading/1'
	@driver.find_element(css: '#start button').click
	wait_for(10) { @driver.find_element(css: '#finish').displayed? }
	expect(@driver.find_element(css: '#finish').text).to eql ('Hello World!')
end

run do
	@driver.get 'http://the-internet.herokuapp.com/dynamic_loading/2'
	@driver.find_element(css: '#start button').click
	wait_for(10) { @driver.find_element(css: '#finish').displayed? }
	expect(@driver.find_element(css: '#finish').text).to eql ('Hello World!')
end




