# encoding: UTF-8

Gem::Specification.new do |s|
  s.name = "spleen"
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.summary = "Ratings solution for Rails"
  s.email = "laurent@spkdev.net"
  s.homepage = "http://github.com/spk/spleen"
  s.description = "Ratings model solution for Rails"
  s.authors = ['Laurent Arnoud']

  s.files = `git ls-files`.split("\n")
  #s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
