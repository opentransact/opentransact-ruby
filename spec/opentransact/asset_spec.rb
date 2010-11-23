require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Asset do
  describe "defaults" do
    
    before(:each) do
      @asset = OpenTransact::Asset.new "https://picomoney.com"
    end
    
    it "should have url" do
      @asset.url.should == "https://picomoney.com"
    end
    
    it "should have transaction url" do
      @asset.transaction_url.should == "https://picomoney.com"
    end
    
    it "should create payment_url" do
      @asset.transfer_url(1123, "bob@test.com", "2 cows").should == "https://picomoney.com?amount=1123&to=bob@test.com&memo=2%20cows"
    end
    
    describe "direct transfer" do
      before(:each) do
        @asset.client = OpenTransact::Client.new :site => "https://picomoney.com", :token=>"my token", :secret=>"my secret"
      end
      
      describe "transfer" do
        before(:each) do
          @access_token = @asset.client.access_token
          @access_token.should_receive(:post).with("https://picomoney.com",{:amount=>1123,:to=>"bob",:memo=>"2 cows"})
        end
        
        it "should perform transfer" do
          @asset.transfer 1123, "bob", "2 cows"
        end
      end
      
      
    end
  end
end
