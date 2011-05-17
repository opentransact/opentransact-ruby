module OpenTransact
  # The Asset is the most important concept in OpenTransact. It represents an asset type.
  class Asset
    attr_accessor :url, :transaction_url, :client, :options
    
    def initialize(url,options={})
      @url = url
      @transaction_url = options[:transaction_url]||@url
      @client = options[:client]
      @options = options||{}
    end
    
    # Create a redirect url for a simple web payment
    #
    #   redirect_to @asset.transfer_url 12, "bob@test.com", "For implementing shopping cart"
    #
    def transfer_url(amount,to,memo,options={})
      uri = URI.parse(transaction_url)
      uri.query = URI.escape("amount=#{amount}&to=#{to}&memo=#{memo}")
      uri.to_s
    end
    
    # Perform a transfer (payment)
    #
    #   @asset.transfer 12, "bob@test.com", "For implementing shopping cart"
    #
    def transfer(amount,to,memo=nil)
      client.post(transaction_url,{:amount=>amount,:to=>to,:memo=>memo}) if client
    end
    
    def name
      @name ||= @options["name"] || info["name"]
    end
    
    def balance
      @balance ||= @options["balance"] || info["balance"]
    end
    
    def available_balance
      @balance ||= @options["available_balance"] || info["available_balance"]
    end
    
    def [](key)
      @options[key] if @options
    end
    
    # Load meta data about asset from server
    def info
      @info ||= client.try(:get, transaction_url)||{}
    end
    
    
    protected
    
      def uri
        @uri ||= URI.parse(url)
      end
  end
end