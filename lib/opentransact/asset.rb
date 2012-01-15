module OpenTransact
  # The Asset is the most important concept in OpenTransact. It represents an asset type.
  class Asset
    include AttrRequired, AttrOptional
    attr_required :url
    attr_optional :client_id, :secret, :access_token, :token_endpoint, :authorization_endpoint

    def initialize(attributes={})
      @attributes = attributes||{}
      (required_attributes + optional_attributes).each do |key|
        self.send :"#{key}=", @attributes[key]
      end
      attr_missing!
    end

    def request(attributes = {})
      OpenTransact::TransferRequest.new attributes.merge({:asset => self})
    end

    def authorize(attributes = {})
      OpenTransact::TransferAuthorization.new attributes.merge({:asset => self, :client_id => @client_id})
    end

    def transfer(attributes = {})
      OpenTransact::Transfer.new attributes.merge({:asset => self, :access_token => @access_token})
    end

  end
end