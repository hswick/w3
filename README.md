# w3

Blockchains are awesome, but developing dapps leaves a lot to be desired. I wanted to ease my pain with a language that was designed to make programmers happy.

ETH + Ruby = <3

## Installation

Ensure you have a blockchain that you can connect to. An easy development one is ganache-cli
`npm install -g ganache-cli`
In a separate tab run `ganache-cli`

This gem has not been released yet, but if you want to contribute or play around with it you can:

1. clone the repo
2. `cd w3`
3. `gem build w3.gemspec`
4. `gem install ./w3-0.0.0.gem`
5. `irb`

Now follow along with this example
```ruby
irb(main):001:0> require 'w3'
=> true
irb(main):002:0> url = "http://localhost:8545"
=> "http://localhost:8545"
irb(main):003:0> http_client = W3::Http_Client.new(url)
=> #<W3::Http_Client:0x000000016cf600 @uri=#<URI::HTTP http://localhost:8545>, @host="localhost", @port=8545>
irb(main):004:0> eth = W3::ETH.new(http_client)
=> #<W3::ETH:0x000000016d7288 @client=#<W3::Http_Client:0x000000016cf600 @uri=#<URI::HTTP http://localhost:8545>, @host="localhost", @port=8545>>
irb(main):005:0> accounts = eth.get_accounts
=> ["0xe0f79b01552163b107b7fc31be6ab5922d9b94ac", "0x2e53f177c1eb8b25472cf03bea5a571771d38f78", "0xc0bccaf70c787ca4d53ed13a6e2c7db123716493", "0x24780b3fd60c3337e58edbb8510a2b0ea4ec776c", "0x45b7ad0e25faa4776ad44777fd6ab7e3ccd0c8a6", "0xeebeb43160e0262b1c033a46a720378bf5284ef0", "0x9e93aaba3fe5ba61e4b941efbc9a26f47c7c0d5b", "0xc59d3844e5fbf5e7c6abce3f606bc5a8996cec26", "0x59079ed9fcbac32ccf2ed4228c8b90f8ac7bb28b", "0xa037170528fb5beffd4f953ac784539530cf2c83"]
```

Or run `ruby test/test.rb`

## Yet another Ethereum client for Ruby?
After looking at other solutions I didn't feel like the other Ethereum libraries only did the job of web3. They either combined the roles of truffle or etherscan, which I didn't feel like was appropriate for the intent of this library.

This was a fun chance to learn the internals of an Ethereum client and how to format the transaction messages.

Wanted to be in full control of my vision for what developing dapps in Ruby could be like. The vision of this library incorporates my experiences working with different languages. I want the Rust community's emphasis on safety because the blockchain space is scary and mistakes cost money. I want Clojure's expressiveness and minimal reliance on objects or classes. I figured I could possibly get both by using the `speculation` gem.

# Desires
- Dynamically create classes based on abi with methods being in snake case
- Getters use `eth_call`, setters use `eth_sendTransaction` and use the bang(!) at end of method names to denote changing of state locally or on the blockchain. This is important because changing state on blockchain costs precious ETH!!!
- Use `speculation` gem to enforce value correctness, type like safety, and present good error messages
- Dynamically create method definition specs based on abi
- Utilize speculation to generate tests to hopefully make development a little bet less about basic tests

Huge shout out to [ethereum.rb](https://github.com/EthWorks/ethereum.rb) for guidance on how to encoding and developing a client.

## The MIT License (MIT)

Copyright 2017 Harley Swick

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.