Gem::Specification.new do |s|
  s.name        = 'w3'
  s.version     = '0.0.0'
  s.date        = '2017-02-08'
  s.summary     = "Ruby Ethereum Client"
  s.description = "Simple, safe, and expressive Ethereum client for Ruby"
  s.authors     = ["Harley Swick"]
  s.email       = 'hdswick@gmail.com'
  s.files       = ["lib/w3.rb"]
  s.homepage    = 'http://rubygems.org/gems/w3'
  s.license     = 'MIT'

  s.add_dependency "speculation"
  #s.add_dependency "digest-sha3"
end