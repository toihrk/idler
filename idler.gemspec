# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'idler/version'

Gem::Specification.new do |spec|
  spec.name          = "idler"
  spec.version       = Idler::VERSION
  spec.authors       = ["toihrk"]
  spec.email         = ["toihrk@me.com"]

  spec.summary       = %q{Idler - Let's lazy the deploy!!}
  spec.description   = %q{Idler is a utility for automatically the deploy or other.}
  spec.homepage      = "https://github.com/toihrk/idler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['idler']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "git"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-doc"
end
