module OpenTransact
  # Create an OpenTransact Transfer Authorization
  # http://www.opentransact.org/core.html#transfer-authorization-1
  class TransferAuthorization < TransferRequest
    attr_required :client_id
  end
end