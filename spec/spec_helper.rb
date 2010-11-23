$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'opentransact'
require 'fakeweb'
require 'rspec'

RSpec::configure do |config|
   FakeWeb.allow_net_connect = false
end
