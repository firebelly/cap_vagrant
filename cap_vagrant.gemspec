# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cap_vagrant/version'

Gem::Specification.new do |gem|
  gem.name          = "cap_vagrant"
  gem.version       = CapVagrant::VERSION
  gem.authors       = ["Lloyd Philbrook"]
  gem.email         = ["lloyd@firebellydesign.com"]
  gem.description   = %q{Create a vagrant stage file for your capistrano deployment.}
  gem.summary       = %q{Create a vagrant stage file for your capistrano deployment.}
  gem.homepage      = "https://github.com/firebelly/cap_vagrant"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "thor"
end
