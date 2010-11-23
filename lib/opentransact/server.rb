require 'oauth/consumer'
module OpenTransact
  
  # This class initially maintains and creates the OAuth Consumer for a particular OAuth site. The idea though is for it to
  # handle various other discovery related features
  class Server
    attr_accessor :url, :options
    
    # Create a server with the url option and optional key and secret
    
    def initialize(options={})
      @options=options||{}
      @url=options[:url]
    end
    
    def [](key)
      @options[key] if @options
    end
    
    def consumer
      @consumer ||= OAuth::Consumer.new @options[:key],  @options[:secret], :site=>@url
    end
  end
end