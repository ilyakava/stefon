# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stefon/version'

Gem::Specification.new do |spec|
  spec.name          = "stefon"
  spec.version       = Stefon::VERSION
  spec.authors       = ["Ilya Kavalerov"]
  spec.email         = ["ilya@artsymail.com"]
  spec.description   = %q{A utilty that recommends who to ask for a code review}
  spec.summary       = %q{A utilty that recommends who to ask for a code review}
  spec.homepage      = "https://github.com/ilyakava/stefon"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "grit", "2.5.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end