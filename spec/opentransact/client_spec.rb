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