require 'rubygems'
require 'selenium-cucumber'

require 'rspec'

require 'watir'
require "page-object"
require "page-object/page_factory"

# Before do
#   $browser = Watir::Browser.new :firefox
# end

$browser_type = ENV['BROWSER'] || 'firefox'

begin
  $driver = Selenium::WebDriver.for(:"#{$browser_type}")
rescue Exception => e
  puts e.message
  Process.exit(0)
end
