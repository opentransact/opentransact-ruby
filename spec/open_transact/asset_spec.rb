require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Asset do
  describe "defaults" do
    
    before(:each) do
      @asset = OpenTransact::Asset.new "http://nubux.heroku.com"
    end
    
    it "should have url" do
      @asset.url.should == "http://nubux.heroku.com"
    end
    
    it "should have transaction url" do
      @asset.transaction_url.should == "http://nubux.heroku.com"
    end
    
    describe "Server" do
      before(:each) do
        @server = @asset.server
      end
      
      it "should have site" do
        @server.url.should=="http://nubux.heroku.com"
      end
      
      it "should have key" do
        @server.consumer.key.should be_nil
      end
      
      it "should have secret" do
        @server.consumer.secret.should be_nil
      end
      
      it "should have a consumer" do
        @asset.consumer.should == @server.consumer
      end
    end
  end
end