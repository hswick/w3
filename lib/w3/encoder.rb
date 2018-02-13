module W3
  module Encoder

    @@encoding = {}

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
      encoded_value = @@encoding[type].call(value)
      raise "Unable to encode type: #{type}" if encoded_value.nil?
      encoded_value
    end

    def self.to_twos_complement(number)
      (number & ((1 << 256) - 1))
    end

    def to_hex_string(value)
      value.to_s(16)
    end

    @@encoding["uint256"] = fn do |value|
      to_twos_complement(value).to_s(16).rjust(64, '0')
    end

    @@encoding["bytes32"] = fn do |value|
      value.bytes.map {|x| x.to_s(16).rjust(2, '0')}.join("").ljust(64, '0')
    end

    @@encoding["bool"] = fn do |value|
      (value ? "1" : "0").rjust(64, '0')
    end

  end
end