require 'w3'

RSpec.describe W3::ETH do
  context "using eth abstraction over client" do
    before do
      url = "http://localhost:8545"
      http_client = W3::Http_Client.new(url)
      @eth = W3::ETH.new(http_client)
      @accounts = @eth.get_accounts
    end

    it "get accounts" do
      expect(@accounts.length > 0).to eq true
      expect(@accounts.class).to eq Array
    end

    it "get block number" do
      block_number = @eth.get_block_number
      expect(block_number >= 0).to eq true
      expect(block_number.class).to eq Integer
    end

    it "get balance of account[0]" do
      balance = @eth.get_balance @accounts[0]
      expect(balance >= 0).to eq true
      expect(balance.class).to eq Integer
    end
  end
end