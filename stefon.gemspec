# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stefon/version'

Gem::Specification.new do |spec|
  spec.name          = 'stefon'
  spec.version       = Stefon::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Ilya Kavalerov']
  spec.email         = ['ilya@artsymail.com']
  spec.description   = <<-EOF
    A pre-commit utility that recommends who to ask for a code review.
    Stefon tells you whose code you are affecting the most.
  EOF
  spec.summary       = %q{A utility that recommends who to ask for a code review}
  spec.homepage      = 'https://github.com/ilyakava/stefon'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'gitlab-grit', '1.0.0'
  spec.add_runtime_dependency 'trollop', '~> 2.0'
  spec.add_development_dependency 'fakefs', '~> 0.5'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'rspec'
end
