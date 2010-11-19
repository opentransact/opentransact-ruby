require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Client do
  
  before(:each) do
    @asset = OpenTransact::Asset.new "http://nubux.heroku.com", :key => "key", :secret => "secret"
  end
  
  describe "defaults" do
    
    before(:each) do
      @client = OpenTransact::Client.new
    end
    
    it "should not have asset" do
      @client.asset.should be_nil
    end
    
  end

  describe "with token" do
    
    before(:each) do
      @client = OpenTransact::Client.new :asset=>@asset, :token=>"my token", :secret=>"my secret"
    end
    
    it "should have token" do
      @client.token.should=="my token"
    end
    
    it "should have secret" do
      @client.secret.should=="my secret"
    end
    
    it "should have asset" do
      @client.asset.should == @asset
    end
    
    it "should have server" do
      @client.server.should == @asset.server
    end
    
    describe "access token" do
      before(:each) do
        @access_token = @client.access_token
      end
      
      it "should have assets consumer" do
        @access_token.consumer.should == @asset.consumer
      end
      
      it "should have token" do
        @access_token.token.should=="my token"
      end

      it "should have secret" do
        @access_token.secret.should=="my secret"
      end
      
      
      describe "transfer" do
        before(:each) do
          @access_token.should_receive(:post).with("http://nubux.heroku.com",{:amount=>1123,:to=>"bob",:memo=>"2 cows"})
        end
        
        it "should perform transfer" do
          @client.transfer 1123, "bob", "2 cows"
        end
      end
    end
  end


end