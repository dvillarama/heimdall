# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heimdall/version'

Gem::Specification.new do |spec|
  spec.name          = "heimdall"
  spec.version       = Heimdall::VERSION
  spec.authors       = ["David Villarama"]
  spec.email         = ["div@zestfinance.com"]
  spec.summary       = %q{ email monitor }
  spec.description   = %q{ monitors an email account }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "pry"
  spec.add_dependency "dante"
  spec.add_dependency "httparty"
  spec.add_dependency "gmail", "~> 0.4.0"
  spec.add_dependency "settingslogic"
end
