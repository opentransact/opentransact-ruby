require 'oauth/consumer'
require 'net/https'
require 'multi_xml'
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
    
    # returns the wellknown url for host-meta
    def host_meta_url
      host_meta_uri.to_s
    end
    
    # returns host_meta xml document
    def host_meta
      @host_meta ||= begin
        request = Net::HTTP::Get.new(host_meta_uri.path)
        http = Net::HTTP.new(host_meta_uri.host, host_meta_uri.port)
        http.use_ssl = (host_meta_uri.port==443)
        response = http.start {|http| http.request(request) }
        raise OpenTransact::UndiscoverableResource unless response.code=="200"
        MultiXml.parse(response.body)["XRD"]
      end
    end
    
    # returns a rel link from host meta
    def rel_link(rel)
      host_meta["Link"].detect{|l| l["rel"]==rel}["href"] if host_meta && host_meta["Link"]
    end
    
    def [](key)
      @options[key] if @options
    end
    
    def consumer
      @consumer ||= OAuth::Consumer.new @options[:key],  @options[:secret], :site=>@url
    end
    
    private
    
      def host_meta_uri
        @uri ||= begin
          uri = URI.parse(@url)
          uri.path="/.well-known/host-meta"
          uri.query=nil
          uri
        end
      end
    
  end
end