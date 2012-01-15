require 'attr_required'
require 'attr_optional'
require 'rack/oauth2'
require "opentransact/asset"
require "opentransact/abstract_transfer"
require "opentransact/transfer_request"
require "opentransact/transfer_authorization"
require "opentransact/transfer"

module OpenTransact
  class UndiscoverableResource < StandardError; end
end