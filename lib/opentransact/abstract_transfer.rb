module OpenTransact
  # Create an OpenTransact Transfer Request
  # http://www.opentransact.org/core.html#transfer-request-1
  class AbstractTransfer
    include AttrRequired, AttrOptional
    attr_required :asset
    attr_optional :to, :from, :amount, :for, :note
    attr_accessor :attributes


    def initialize(attributes={})
      (required_attributes + optional_attributes).each do |key|
        self.send :"#{key}=", attributes[key]
      end
      @attributes = attributes
      @attributes.delete(:asset)
      attr_missing!
    end

    def query_string
      @query_string ||= Rack::OAuth2::Util.compact_hash(attributes).to_query
    end
  end
end