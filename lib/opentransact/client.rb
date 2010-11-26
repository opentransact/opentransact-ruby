require 'oauth'
require 'oauth/tokens/access_token'
require 'multi_json'
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
    
    # returns the assets on a particular server
    def assets
      []
    end
    
    # returns the assets on the server for a particular client
    def wallet
      @wallet ||= wallet_list.collect do |a| 
        OpenTransact::Asset.new(a.delete("url"),a.merge({:client=>self}))
      end
    end
    
    def wallet_list
      @wallet_list ||= get(server.rel_link("http://opentransact.org/rel/wallet"))["assets"] ||[]
    end
        
    def server
      @server ||= options[:server] || OpenTransact::Server.new( :url=>site, :key=>options[:consumer_key], :secret=>options[:consumer_secret])
    end
    
    def put(path,params={})
      parse(access_token.put(path,params, {'Accept' => 'application/json'}))
    end

    def delete(path)
      parse(access_token.delete(path, {'Accept' => 'application/json'}))
    end

    def post(path,params={})
      parse(access_token.post(path,params, {'Accept' => 'application/json'}))
    end

    def get(path)
      parse(access_token.get(path, {'Accept' => 'application/json'}))
    end
    
    
    protected
    
    def parse(response)
      return false unless response
      if ["200","201"].include? response.code
        unless response.body.nil?
          MultiJson.decode(response.body)
        else
          true
        end
      else
        false
      end
      
    end
    
      def token
        options[:token]
      end
    
      def secret
        options[:secret]
      end
        
  end
end