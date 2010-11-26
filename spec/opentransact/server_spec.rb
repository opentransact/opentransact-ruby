require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Server do
  describe "without credentials" do
    before(:each) do
      @server = OpenTransact::Server.new :url => "https://picomoney.com"
    end
    
    it "should have host-meta url" do
      @server.host_meta_url.should == "https://picomoney.com/.well-known/host-meta"
    end
    
    it "should have url" do
      @server.url.should == "https://picomoney.com"
    end
    
    describe "check host-meta" do
      before(:each) do
        FakeWeb.register_uri(:get, "https://picomoney.com/.well-known/host-meta", :body => read_fixture("host-meta.xml"))
      end
      
      it "should contain parsed xml" do
        @server.host_meta.class.should==Nokogiri::XML::Document
      end
      
      { 
        "http://opentransact.org/rel/wallet"  => "https://picomoney.com/wallet",
        "http://opentransact.org/rel/assets"  => "https://picomoney.com/.well-known/opentransact",
        "http://opentransact.org/rel/history" => "https://picomoney.com/picos/all"
      }.each do |rel|
        
        it "should have #{rel[0]} link" do
          @server.rel_link(rel[0]).should == rel[1]
        end
        
      end
      
    end
    
    describe "no host-meta" do
      before(:each) do
        FakeWeb.register_uri(:get, "https://picomoney.com/.well-known/host-meta", :status => ["404", "Not Found"])
      end
      
      it "should raise Undiscoverable Resource" do
        lambda { @server.host_meta }.should raise_error(OpenTransact::UndiscoverableResource)
      end
    end
  end
  
  describe "with consumer credentials" do
    
    before(:each) do
      @server = OpenTransact::Server.new :url => "https://picomoney.com", :key=>"consumer_key", :secret=>"consumer_secret"
    end
    
    it "should have host-meta url" do
      @server.host_meta_url.should == "https://picomoney.com/.well-known/host-meta"
    end
    
    it "should have url" do
      @server.url.should == "https://picomoney.com"
    end
    
    it "have key" do
      @server[:key].should == "consumer_key"
    end
    
    it "have secret" do
      @server[:secret].should == "consumer_secret"
    end
    
    describe "Consumer" do
      before(:each) do
        @consumer = @server.consumer
      end
      
      it "should have site" do
        @consumer.site.should=="https://picomoney.com"
      end
      
      it "should have key" do
        @consumer.key.should=="consumer_key"
      end
      
      it "should have secret" do
        @consumer.secret.should=="consumer_secret"
      end
    end
  end
end