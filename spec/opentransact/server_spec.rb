require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Server do
  describe "defaults" do
    
    before(:each) do
      @server = OpenTransact::Server.new :url => "http://nubux.heroku.com", :key=>"consumer_key", :secret=>"consumer_secret"
    end
    
    it "should have url" do
      @server.url.should == "http://nubux.heroku.com"
    end
    
    describe "Consumer" do
      before(:each) do
        @consumer = @server.consumer
      end
      
      it "should have site" do
        @consumer.site.should=="http://nubux.heroku.com"
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