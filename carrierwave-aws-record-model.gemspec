# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/aws/record/model/version'

Gem::Specification.new do |gem|
  gem.name          = "carrierwave-aws-record-model"
  gem.version       = CarrierWave::AWS::Record::Model::VERSION
  gem.authors       = ["Jeremy Green"]
  gem.email         = ["jeremy@octolabs.com"]
  gem.description   = %q{CarrierWave for AWS::Record::Model}
  gem.summary       = %q{CarrierWave for AWS::Record::Model}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]


  gem.add_dependency "carrierwave", "~> 0.8.0"
  gem.add_dependency "aws-sdk", "~> 1.8.1.3"
  gem.add_dependency "simple_callbacks", "~> 0.0.2"
  gem.add_development_dependency "rspec", "~> 2.12.0"
  gem.add_development_dependency "debugger"

end
