require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Asset do
  subject { asset }
  let(:asset) { OpenTransact::Asset.new attributes }
  let(:attributes) { required_attributes }
  let :required_attributes do
    {
      :url => 'https://someurl.example.com/usd'
    }
  end

  its(:url) { should == 'https://someurl.example.com/usd' }

  describe "request" do
    subject { asset.request transfer_attributes }
    let(:transfer_attributes) { {} }
    it { should be_a OpenTransact::TransferRequest}
    its(:url) { should == 'https://someurl.example.com/usd' }
    its(:attributes) { should == {} }
    its(:asset) { should == asset}

    context "all parameters" do
      let(:transfer_attributes) do
        {
          :to => "alice@example.com",
          :from => "bob@example.com",
          :amount => 12.4,
          :note => "Thanks for that",
          :for => "http://stuff.sample.com/invoice/123",
          :redirect_uri => "http://stuff.sample.com/invoice/123/redirect",
          :callback_uri => "http://stuff.sample.com/invoice/123/cb"
        }
      end

      its(:url) { should == 'https://someurl.example.com/usd?amount=12.4&callback_uri=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123%2Fcb&for=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123&from=bob%40example.com&note=Thanks+for+that&redirect_uri=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123%2Fredirect&to=alice%40example.com' }
      its(:attributes) { should == {
        :to => "alice@example.com",
        :from => "bob@example.com",
        :amount => 12.4,
        :note => "Thanks for that",
        :for => "http://stuff.sample.com/invoice/123",
        :redirect_uri => "http://stuff.sample.com/invoice/123/redirect",
        :callback_uri => "http://stuff.sample.com/invoice/123/cb"
        }
      }

    end

  end

  describe "authorize" do
    subject { asset.authorize transfer_attributes }
    let(:attributes) {
      required_attributes.merge({:client_id => 'cr_1234'})
    }
    let(:transfer_attributes) { {} }
    it { should be_a OpenTransact::TransferAuthorization}
    its(:url) { should == 'https://someurl.example.com/usd?client_id=cr_1234' }
    its(:attributes) { should == {:client_id => 'cr_1234'} }
    its(:asset) { should == asset}

    context "all parameters" do
      let(:transfer_attributes) do
        {
          :to => "alice@example.com",
          :from => "bob@example.com",
          :amount => 12.4,
          :note => "Thanks for that",
          :for => "http://stuff.sample.com/invoice/123",
          :redirect_uri => "http://stuff.sample.com/invoice/123/redirect",
          :callback_uri => "http://stuff.sample.com/invoice/123/cb"
        }
      end

      its(:url) { should == 'https://someurl.example.com/usd?amount=12.4&callback_uri=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123%2Fcb&client_id=cr_1234&for=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123&from=bob%40example.com&note=Thanks+for+that&redirect_uri=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123%2Fredirect&to=alice%40example.com' }
      its(:attributes) { should == {
        :client_id => "cr_1234",
        :to => "alice@example.com",
        :from => "bob@example.com",
        :amount => 12.4,
        :note => "Thanks for that",
        :for => "http://stuff.sample.com/invoice/123",
        :redirect_uri => "http://stuff.sample.com/invoice/123/redirect",
        :callback_uri => "http://stuff.sample.com/invoice/123/cb"
        }
      }

    end

  end

  describe "transfer" do
    subject { asset.transfer transfer_attributes }
    let(:attributes) {
      required_attributes.merge({:access_token => access_token})
    }
    let(:access_token) { double("access_token") }
    let(:transfer_attributes) { {} }
    it { should be_a OpenTransact::Transfer }
    its(:url) { should == 'https://someurl.example.com/usd' }
    its(:access_token) { should == access_token }
    its(:attributes) { should == {} }
    its(:asset) { should == asset }

    context "all parameters" do
      let(:transfer_attributes) do
        {
          :to => "alice@example.com",
          :from => "bob@example.com",
          :amount => 12.4,
          :note => "Thanks for that",
          :for => "http://stuff.sample.com/invoice/123"
        }
      end

      its(:url) { should == 'https://someurl.example.com/usd' }
      its(:attributes) { should == {
        :to => "alice@example.com",
        :from => "bob@example.com",
        :amount => 12.4,
        :note => "Thanks for that",
        :for => "http://stuff.sample.com/invoice/123"
        }
      }

    end

  end

  describe "transfer!" do
    let(:attributes) {
      required_attributes.merge({:access_token => access_token})
    }
    let(:access_token) { double("access_token") }

    it "should perform transfer" do
      access_token.should_receive(:post).with('https://someurl.example.com/usd',  'amount=12.4&for=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123&from=bob%40example.com&note=Thanks+for+that&to=alice%40example.com')

      asset.transfer!({
        :to => "alice@example.com",
        :from => "bob@example.com",
        :amount => 12.4,
        :note => "Thanks for that",
        :for => "http://stuff.sample.com/invoice/123"
      })
    end
  end

end