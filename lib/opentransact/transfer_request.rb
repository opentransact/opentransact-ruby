module OpenTransact
  # Create an OpenTransact Transfer Request
  # http://www.opentransact.org/core.html#transfer-request-1
  class TransferRequest < AbstractTransfer
    attr_optional :redirect_uri, :callback_uri

    # returns the url to redirect or link to
    def url
      @asset.url + (query_string != '' ? "?#{query_string}" : '')
    end

  end
end