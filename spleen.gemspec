# encoding: UTF-8
require './lib/spleen'

Gem::Specification.new do |s|
  s.name = "spleen"
  s.version = Spleen::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Ratings solution for Rails"
  s.email = "laurent@spkdev.net"
  s.homepage = "http://github.com/spk/spleen"
  s.description = "Ratings model solution for Rails"
  s.authors = ['Laurent Arnoud']

  s.add_development_dependency "activerecord", "~> 3.1"
  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_development_dependency "minitest", "~> 2.4.0"
  s.add_development_dependency "i18n", "~> 0.6.0"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
