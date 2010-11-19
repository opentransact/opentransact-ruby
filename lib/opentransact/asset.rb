module OpenTransact
  class Asset
    attr_accessor :url, :transaction_url, :options
    
    def initialize(url,options={})
      @url = url
      @transaction_url = options[:transaction_url]||@url
      @options = options||{}
    end
    
    def server
      @server ||= Server.new :key=>@options[:key],  :secret=>@options[:secret], :url=>@url
    end
    
    def consumer
      server && server.consumer || nil
    end
    
  end
end