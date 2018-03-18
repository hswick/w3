# Taken from http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-underscore
class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

module W3

  class Contract

    include Encoder
    include Decoder
    attr_reader :abi, :address, :contract_name
    
    def initialize(eth, abi, address=nil, contract_name="")
      @eth = check_spec eth, W3::ETH
      @abi = check_spec abi, S.coll_of(Hash) 
      @address = address
      @contract_name = contract_name
  
      #dynamically generate methods
      @abi.each do |method_spec|
        #pp method_spec
        if method_spec["type"] == "function"
          if method_spec["constant"]
            gen_getter method_spec
          else
            gen_setter method_spec
          end
        elsif method_spec["type"] == "constructor"
          @constructor_args = method_spec["inputs"]
        end
      end
    end

    def at!(address)
      @address = address
    end

    def deploy!(contract_binary, options, *args)
      encoded_inputs = W3::Encoder::encode_inputs(args, @constructor_args)
      tx = @eth.send_transaction!({
        "from" => options["from"],
        "data" => encoded_inputs.unshift("0x" + contract_binary).join,
        "gas" => "0x" + to_hex_string(options["gas"])
      })
      receipt = @eth.get_tx_receipt(tx)
      if receipt['status'] == 0
        throw "Contract was not successfully deployed"
      end
      receipt["contractAddress"]
    end
  
    private
    def check_spec(value, spec)
      raise S.explain_str(spec, value) if S.invalid? S.conform(spec, value)
      value
    end

    def gen_method_id(name, types)
      id = String.new(name)
      id << "("
      types.each do |type|
        id << type + ","
      end
      id.chop! if id[-1] == ','
      id + ")"
    end

    def get_types(method_spec)
      [].tap do |types|
        method_spec["inputs"].each do |input|
          types << input["type"]
        end
      end
    end

    def calc_id(signature)
      Digest::SHA3.hexdigest(signature, 256)[0..7]
    end

    # TODO: add support for options args
    def gen_getter(method_spec)
      method_id = "0x" + calc_id(gen_method_id(method_spec["name"], get_types(method_spec)))
      self.class.send(:define_method, method_spec["name"].underscore) do |*args|
        encoded_inputs = W3::Encoder::encode_inputs(args, method_spec["inputs"])
        outputs = @eth.call({
          "to" => @address,
          "data" => encoded_inputs.unshift(method_id).join
        })
        W3::Decoder::decode_outputs(outputs, method_spec["outputs"])
      end
    end
  
    # TODO: Make sure to check for options
    def gen_setter(method_spec)
      method_id = "0x" + calc_id(gen_method_id(method_spec["name"], get_types(method_spec)))
      self.class.send(:define_method, method_spec["name"].underscore << "!") do |*args|
        options = args[-1]
        encoded_inputs = W3::Encoder::encode_inputs(args[0..-2], method_spec["inputs"])
        @eth.send_transaction!({
          "from" => options["from"],
          "to" => @address,
          "data" => encoded_inputs.unshift(method_id).join
        })
      end
    end
  end
end