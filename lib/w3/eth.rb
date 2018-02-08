module W3
  class ETH
    attr_accessor :client
  
    def initialize(client)
      @client = client
    end
  
    def send_message(payload)
      @client.send(
        JSON.generate(
          {
            "jsonrpc" => "2.0",
            "params" => [],
            "id" => 0
          }.merge(payload)
        )
      )["result"]
    end
  
    def get_accounts
      send_message({ 
        "method" => "eth_accounts" 
      })
    end
  
    def get_block_number
      Integer(
        send_message({ 
          "method" => "eth_blockNumber" 
        })
      )
    end
  
    def get_balance(account)
      Integer(
        send_message({
          "method" => "eth_getBalance",
          "params" => [account, "latest"]
        })
      )
    end

    def call(params)
      send_message({
        "method" => "eth_call",
        "params" => [params]
      })
    end

    def get_tx_receipt(receipt_id)
      send_message({
        "method" => 'eth_getTransactionReceipt',
        "params" => [receipt_id]
      })
    end
  
    #Expecting a map
    def send_transaction!(params)
      send_message({
        "method" => "eth_sendTransaction",
        "params" => [params]
      })
    end
  end
end