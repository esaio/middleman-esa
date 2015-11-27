# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-esa"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["fukayatsu"]
  s.email       = ["fukayatsu@gmail.com"]
  s.homepage    = "https://github.com/esaio/middleman-esa"
  s.summary     = %q{esa engine for Middleman}
  s.description = %q{esa engine for Middleman}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "middleman-core", "~> 3.4.0"
  s.add_dependency "addressable", "~> 2.3.5"
end
