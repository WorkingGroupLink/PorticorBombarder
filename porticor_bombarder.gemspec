# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'porticor_bombarder/version'

Gem::Specification.new do |spec|
  spec.name = 'porticor_bombarder'
  spec.version = PorticorBombarder::VERSION
  spec.authors = ['rajeevkannav']
  spec.email = ['rajeevsharma86@gmail.com']
  spec.summary = %q{Porticor + StrongBox}
  spec.description = %q{Encrypt activerecord attributes with Porticor's encrypted keys management.}
  spec.homepage = 'https://github.com/rajeevkannav/PorticorBombarder'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0.8'

  #
  #runtime_dependencies
  #
  spec.add_runtime_dependency 'rails', '~> 4.0'
  spec.add_runtime_dependency 'activerecord', '~> 4.0'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.9'
  spec.add_runtime_dependency 'hashie', '~> 3.3'
  spec.add_runtime_dependency 'strongbox', '~> 0.7'

end
