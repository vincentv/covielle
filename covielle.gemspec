# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'covielle/version'

Gem::Specification.new do |gem|
  gem.name          = "covielle"
  gem.version       = Covielle::VERSION
  gem.authors       = ["Vincentv"]
  gem.email         = ["lsuntzu+covielle[at]gmail[dot]com"]
  gem.description   = "Write a gem description"
  gem.summary       = %q{ Write a gem summary}
  gem.homepage      = "https://github.com/vincentv/covielle"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'thor'

  gem.add_development_dependency 'minitest'
end
