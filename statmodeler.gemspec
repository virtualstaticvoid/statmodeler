# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "statmodeler/version"

Gem::Specification.new do |s|

  s.name        = "statmodeler"
  s.summary     = %q{Ruby DSL for statistical, quantitive or mathematical models}
  s.description = %q{Defines a Ruby DSL for defining mathematical, statistical or quantitive models and a processing/calculation engine.}
  s.homepage    = "https://github.com/virtualstaticvoid/statmodeler"
  s.authors     = ["Chris Stefano"]
  s.email       = ["virtualstaticvoid@gmail.com"]

  s.version     = Statmodeler::VERSION
  s.platform    = Gem::Platform::RUBY

  s.rubyforge_project = "statmodeler"

  # dependencies here
  s.add_dependency 'fastercsv', ['>= 1.5.3']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end

