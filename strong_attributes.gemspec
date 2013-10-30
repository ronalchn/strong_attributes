# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'strong_attributes/version'

Gem::Specification.new do |gem|
  gem.name          = "strong_attributes"
  gem.version       = StrongAttributes::VERSION
  gem.authors       = ["Ronald Chan"]
  gem.email         = ["ronalchn@gmail.com"]
  gem.description   = %q{strong_attributes provides a strong_parameters-style permit interface using a wrapper around your model. By accessing model attributes in your views only through this interface, you ensure that any attributes displayed are explicitly permitted, and sensitive data is not displayed to unauthorized users. This keeps your views free of authorization logic.}
  gem.summary       = %q{strong_attributes provides a strong_parameters-style permit interface using a wrapper around your model. By accessing model attributes in your views only through this interface, you ensure that any attributes displayed are explicitly permitted, and sensitive data is not displayed to unauthorized users. This keeps your views free of authorization logic.}
  gem.homepage      = "https://github.com/ronalchn/strong_attributes"
  gem.license       = "MPLv2"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport', '>= 3.0'

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency 'rake', '>= 0.9.2'
  gem.add_development_dependency 'rspec', '~> 2.12'
  gem.add_development_dependency 'rspec-mocks', '>= 2.12.1'
end
