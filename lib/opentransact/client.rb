require 'oauth/tokens/access_token'
module OpenTransact
  # The main OpenTransact client access point. It wraps around an OAuth Token.
  class Client
    attr_accessor :server, :token, :secret, :options, :site
    
    # Create a client:
    #
    #   # no oauth
    #   @client = OpenTransact::Client.new "http://picomoney.com"
    #
    #   # with oauth credentials
    #   @client = OpenTransact::Client.new "https://picomoney.com", 
    #                :token => "my token", :secret => "my secret", 
    #                :consumer_key => "consumer key", :consumer_secret => "consumer secret"
    #
    #   # with pre initialized server
    #   @client = OpenTransact::Client.new "https://picomoney.com",
    # =>             :server => @server, 
    #                :token => "my token", :secret => "my secret"
    #
    def initialize(*params)
      @options = params.pop if params.last.is_a?(Hash)
      @options ||= {}
      @site = params.first || options[:site]
    end
    
    # returns an oauth access token
    def access_token
      @access_token ||= OAuth::AccessToken.new server.consumer, token, secret if server
    end
    
    # returns the assets on the server for a particular client
    def assets
      []
    end
        
    def server
      @server ||= options[:server] || OpenTransact::Server.new( :url=>site, :key=>options[:consumer_key], :secret=>options[:consumer_secret])
    end
    
    protected
    
      def token
        options[:token]
      end
    
      def secret
        options[:secret]
      end
        
  end
end