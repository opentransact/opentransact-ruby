$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'opentransact'
require 'fakeweb'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
   FakeWeb.allow_net_connect = false
end
