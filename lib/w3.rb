require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'json'
require 'pp'
require 'digest/sha3'
require 'w3/version'

module W3
  require 'w3/encoder'
  require 'w3/decoder'
  require 'w3/http_client'
  require 'w3/eth'
  require 'w3/contract'
end