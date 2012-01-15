require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Transfer do
  subject { transfer }
  let(:transfer) { OpenTransact::Transfer.new attributes }
  let(:asset) { OpenTransact::Asset.new asset_attributes }
  let(:attributes) { required_attributes }

  let :required_attributes do
    {
      :asset => asset,
      :access_token => "tk_12323"
    }
  end

  let :asset_attributes do
    {
      :url => 'https://someurl.example.com/usd'
    }
  end

  its(:url) { should == 'https://someurl.example.com/usd' }
  its(:access_token) { should == "tk_12323"}
  its(:attributes) { should == { } }

  context "all parameters" do
    let(:attributes) do
      required_attributes.merge({
        :to => "alice@example.com",
        :from => "bob@example.com",
        :amount => 12.4,
        :note => "Thanks for that",
        :for => "http://stuff.sample.com/invoice/123",
        :redirect_uri => "http://stuff.sample.com/invoice/123/redirect",
        :callback_uri => "http://stuff.sample.com/invoice/123/cb"
      })
    end
    its(:url) { should == 'https://someurl.example.com/usd' }
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