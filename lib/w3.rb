require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'json'
require 'pp'
require 'digest/sha3'
require 'w3/version'
require 'speculation'

S = Speculation

# Getting a bit more clojurey
def fn(&block)
  block
end

module W3
  require 'w3/eth_type'
  require 'w3/encoder'
  require 'w3/decoder'
  require 'w3/http_client'
  require 'w3/eth'
  require 'w3/contract'
end