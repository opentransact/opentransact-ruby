require 'attr_required'
require 'attr_optional'
require 'httpclient'
require 'active_support/core_ext'
require "opentransact/asset"
require "opentransact/abstract_transfer"
require "opentransact/transfer_request"
require "opentransact/transfer_authorization"
require "opentransact/transfer"

module OpenTransact
  class UndiscoverableResource < StandardError; end
end