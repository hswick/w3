require 'w3'

url = "http://localhost:8545"
http_client = W3::Http_Client.new(url)

eth = W3::ETH.new(http_client)

accounts = eth.get_accounts
pp accounts

puts "Block number: #{eth.get_block_number}"

simple_storage = W3::Contract.new(eth, "SimpleStorage")

bin =  File.read('./build/SimpleStorage.bin')
simple_storage.at! simple_storage.deploy!(bin, {"from" => accounts[0], "gas" => 300000})

pp simple_storage.get
simple_storage.set!(2, {"from" => accounts[0]})
pp simple_storage.get