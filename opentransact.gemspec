# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "opentransact/version"

Gem::Specification.new do |s|
  s.name        = "opentransact"
  s.version     = OpenTransact::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Pelle Braendgaard"]
  s.email       = ["pelle@stakeventures.com"]
  s.homepage    = "http://opentransact.org"
  s.summary     = %q{OpenTransact client for Ruby}
  s.description = %q{OpenTransact client for Ruby}

  s.rubyforge_project = "opentransact"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "fuubar"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "growl"

  s.add_runtime_dependency "httpclient", ">= 2.2.0.2"
  s.add_runtime_dependency "activesupport", ">= 2.3"
  s.add_runtime_dependency "i18n"
  s.add_runtime_dependency "attr_required", ">= 0.0.3"
  s.add_dependency "multi_json"
  s.add_dependency 'rack'
end
