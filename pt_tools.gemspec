# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pt_tools/version'

Gem::Specification.new do |spec|
  spec.name          = 'pt_tools'
  spec.version       = PtTools::VERSION
  spec.authors       = ['Matt Chun-Lum']
  spec.email         = ['matt@slideshare.com']
  spec.summary       = %q{A CLI to make pivotal less annoying}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'
  spec.add_dependency 'rest-client'
  spec.add_dependency 'configatron'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
