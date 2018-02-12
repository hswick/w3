# w3

Blockchains are awesome, but developing dapps leaves a lot to be desired. I wanted to ease my pain with a language that was designed to make programmers happy.

ETH + Ruby = <3

## Installation

Ensure you have ruby and bundle installed. It is recommended you install ruby with rvm.

Install bundler: `gem install bundler`

Clone this repo
```
cd w3
bundle install
```


Ensure you have a blockchain that you can connect to. An easy development one is ganache-cli
`npm install -g ganache-cli`
In a separate tab run `ganache-cli`

Then to run the tests you can do:
```
rspec --format doc
```

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

Huge shout out to [ethereum.rb](https://github.com/EthWorks/ethereum.rb) for guidance and inspiration.

## The MIT License (MIT)

Copyright 2017 Harley Swick

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.