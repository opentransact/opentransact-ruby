require 'oauth/consumer'
module OpenTransact
  class Server
    attr_accessor :url, :options
    
    def initialize(options={})
      @options=options||{}
      @url=options[:url]
    end
    
    def consumer
      @consumer ||= OAuth::Consumer.new @options[:key],  @options[:secret], :site=>@url
    end
  end
end