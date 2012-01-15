# OpenTransact Ruby Client

This library provides an easy to use client for interacting with (OpenTransact)[http://opentransact.org] financial service providers.

This is currently a work in progress and we need to add better error checking, exceptions etc.

== Quick start

An OpenTransact asset is a server that accepts either a http POST or GET request containing a to and an amount field.

There are 3 major ways of performing a transfer/payment with OpenTransact.

* Transfer Request
* Transfer Authorization
* Transfer

## Transfer Request

You use the Transfer Request as a really simple way to request payment from someone.

In your controller create a Asset object and redirect to url:

    @asset = OpenTransact::Asset.new :url => "http://picomoney.com/pelle-hours"
    @request = @asset.request :amount => 12, :to => "bob@test.com", :note => "For implementing shopping cart", :redirect_uri => "http://mysite.com/order/123"
    redirect_to @request.url

The server will redirect you back to the url you specified in the redirect_uri.

See (Transfer Request Response)[http://www.opentransact.org/core.html#response] for more details.

## Transfer Authorization

The Transfer Authorization requires you to have a pre registered OAuth 2 Client with the asset:

    @asset = OpenTransact::Asset.new :url => "http://picomoney.com/pelle-hours", :client_id => "abdef123", :secret => "asdfasdf"
    @authorization = @asset.authorize :amount => 12, :to => "bob@test.com", :note => "For implementing shopping cart", :redirect_uri => "http://mysite.com/order/123"
    redirect_to @authorization.url

The server will redirect you back to the url you specified in the redirect_uri.

See (Transfer Authorization Response)[http://www.opentransact.org/core.html#response-1] for more details.


## Transfer

The Transfer Authorization requires you to have a pre registered OAuth 2 Client with the asset:

    @asset = OpenTransact::Asset.new :url => "http://picomoney.com/pelle-hours", :access_token => "asfasdf1123123"
    @transfer = @asset.transfer :amount => 12, :to => "bob@test.com", :note => "For implementing shopping cart", :redirect_uri => "http://mysite.com/order/123"

TBD actually perform payment



== Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2010-12 Pelle Braendgaard and contributors. See LICENSE for details.
