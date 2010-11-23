require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Server do
  describe "defaults" do
    
    before(:each) do
      @server = OpenTransact::Server.new :url => "https://picomoney.com", :key=>"consumer_key", :secret=>"consumer_secret"
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