module W3
  module Encoder

    def encode_inputs(inputs, inputs_spec)
      if inputs && inputs_spec
        [].tap do |input|
          inputs_spec.each_with_index do |input_type, i|
            encoded = encode_value(input_type["type"], inputs[i])
            input.push encoded
          end
        end
      else
        []
      end
    end

    def encode_value(type, value)
      case type
      when "uint256"
        encode_int(value)
      when "bytes32"
        encode_static_bytes(value)
      when "bool"
        encode_bool(value)
      else
        raise "Unable to encode type: #{type}"
      end
    end

    def encode_int(value)
      to_twos_complement(value).to_s(16).rjust(64, '0')
    end

    def encode_static_bytes(value)
      value.bytes.map {|x| x.to_s(16).rjust(2, '0')}.join("").ljust(64, '0')
    end

    def encode_bool(value)
      (value ? "1" : "0").rjust(64, '0')
    end
  
    def to_twos_complement(number)
      (number & ((1 << 256) - 1))
    end

    def to_hex_string(value)
      value.to_s(16)
    end

  end
end