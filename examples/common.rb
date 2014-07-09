require 'appium_ios_driver'
require 'pry-byebug'
require 'wrong'

include Wrong::Assert

capabilities = Appium::Capabilities::Simulator.new do |capabilities|
  capabilities.device_name = 'iPhone Simulator'
  capabilities.app = File.join(File.dirname(__FILE__), *%w[.. build UICatalog.app])
  capabilities.auto_accept_alerts = true
  capabilities.new_command_timeout = 600
end

$driver = Appium::IOSDriver.new(capabilities)
