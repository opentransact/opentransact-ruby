require 'oauth/tokens/access_token'
module OpenTransact
  class Client
    attr_accessor :asset,:server, :token, :secret, :options
    
    def initialize(options={})
      @asset=options.delete(:asset)
      @server=options.delete(:server)
      @token=options.delete(:token)
      @secret=options.delete(:secret)
      @options = options||{}
    end
    
    def transfer(amount,to,memo=nil)
      access_token.post(asset.transaction_url,{:amount=>amount,:to=>to,:memo=>memo})
    end
    
    def access_token
      @access_token ||= OAuth::AccessToken.new @asset.consumer, @token, @secret
    end
    
    def server
      @server ||=( @asset && @asset.server || nil)
    end
    
  end
end