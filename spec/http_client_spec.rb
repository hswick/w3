require 'w3'

RSpec.describe W3::Http_Client do
  context "using w3 http_client" do
    it "sends a simple message" do
      url = "http://localhost:8545"
      http_client = W3::Http_Client.new(url)
      message = {"jsonrpc" => "2.0", "params" => [], "id" => 0, "method" => "eth_accounts"}
      accounts = http_client.send(JSON.generate(message))["result"]
      expect(accounts.length > 0).to eq true
      expect(accounts.class).to eq Array
    end
  end
end