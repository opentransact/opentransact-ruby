require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Client do
    
  describe "no credentials" do
    
    before(:each) do
      @client = OpenTransact::Client.new "https://picomoney.com"
    end
    
    it "should not have assets" do
      @client.assets.should == []
    end
    
    it "have site" do
      @client.site.should == "https://picomoney.com"
    end
    
    describe "server" do
      subject { @client.server }
      it { should_not be_nil }
      it { subject.url.should == "https://picomoney.com" }
      it { subject[:key].should be_nil }
      it { subject[:secret].should be_nil }
      
    end
  end
  
  describe "no credentials site in options" do
    
    before(:each) do
      @client = OpenTransact::Client.new :site => "https://picomoney.com"
    end
    
    it "should not have assets" do
      @client.assets.should == []
    end
    
    it "have site" do
      @client.site.should == "https://picomoney.com"
    end
    
    
    describe "server" do
      subject { @client.server }
      it { should_not be_nil }
      it { subject.url.should == "https://picomoney.com" }
    end
  end

  describe "with token" do
    
    before(:each) do
      @client = OpenTransact::Client.new "https://picomoney.com", 
                      :token => "my token", :secret => "my secret", 
                      :consumer_key => "consumer key", :consumer_secret => "consumer secret"
        
    end
    
    it "should have token" do
      @client.send(:token).should=="my token"
    end
    
    it "should have secret" do
      @client.send(:secret).should=="my secret"
    end
    
    describe "server" do
      subject { @client.server }
      it { should_not be_nil }
      it { subject.url.should == "https://picomoney.com" }
      
      it { subject[:key].should == "consumer key" }
      it { subject[:secret].should == "consumer secret" }
    end
    
    describe "wallet" do
      before(:each) do
        FakeWeb.register_uri(:get, "https://picomoney.com/.well-known/host-meta", :body => read_fixture("host-meta.xml"))
        FakeWeb.register_uri(:get, "https://picomoney.com/wallet", :body => read_fixture("wallet_with_balances.json"))
      end
      
      it "should have wallet list" do
        @client.wallet_list.should == [
          {"name"=>"PicoPoints", "url"=>"https://picomoney.com/picopoints", "balance"=>123}, 
          {"name"=>"Bob Smith hours", "url"=>"https://picomoney.com/bob-smith-hours", "balance"=>3}, 
          {"name"=>"OpenTransact Karma", "url"=>"https://picomoney.com/opentransact-karma"}]
      end
      
      it "should have 3 assets wallet" do
        @client.should have(3).wallet
      end
      
      describe "asset" do
        before(:each) do
          @asset = @client.wallet.first
        end
        
        it "should have name" do
          @asset.name.should == "PicoPoints"
        end
        
        it "should have url" do
          @asset.url.should == "https://picomoney.com/picopoints"
        end
        
        it "should have balance" do
          @asset.balance.should == 123
        end
        
        it "should have client" do
          @asset.client.should == @client
        end
      end
    end
    
    describe "access token" do
      before(:each) do
        @access_token = @client.access_token
      end
      
      it "have be created" do
        @access_token.should_not be_nil
      end
      
      it "should have assets consumer" do
        @access_token.consumer.should == @client.server.consumer
      end
      
      it "should have token" do
        @access_token.token.should=="my token"
      end

      it "should have secret" do
        @access_token.secret.should=="my secret"
      end
    end
  end


end