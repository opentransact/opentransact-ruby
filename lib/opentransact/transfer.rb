module OpenTransact
  # Create an OpenTransact Transfer Authorization
  # http://www.opentransact.org/core.html#transfer-authorization-1
  class Transfer < AbstractTransfer
    attr_required :access_token
    delegate :url, :to => :asset

    def initialize(attributes = {})
      super attributes
      @attributes.delete(:access_token)
    end
  end
end