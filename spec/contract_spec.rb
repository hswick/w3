require 'w3'

RSpec.describe W3::Contract do
  before(:example) do
    url = "http://localhost:8545"
    http_client = W3::Http_Client.new(url)
    @eth = W3::ETH.new(http_client)
    @accounts = @eth.get_accounts
    @simple_storage = W3::Contract.new(@eth, "SimpleStorage")
  end

  context "using simple storage contract" do
    before(:example) do
      bin =  File.read('./build/SimpleStorage.bin')
      @simple_storage.at! @simple_storage.deploy!(bin, {"from" => @accounts[0], "gas" => 300000})
    end

    it 'gets state' do
      num = @simple_storage.get
      expect(num).to eq 0
    end

    it 'sets state, and gets updated state' do
      @simple_storage.set! 42, {"from" => @accounts[0]}
      expect(@simple_storage.get).to eq 42
    end
  end
end