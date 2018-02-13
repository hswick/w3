module W3
  module Decoder

    @@decoding = {}

    def decode_outputs(output_string, outputs_spec)
      outputs = output_string[2..-1].scan(/.{1,64}/)
      if outputs_spec.length > 1
        {}.tap do |output|
          outputs_spec.each_with_index do |output_type, i|
            if output_type["name"].empty?
              output[i] = decode_value(output_type["type"], outputs[i])
            else
              output[output_type["name"]] = decode_value(output_type["type"], outputs[i])
            end
          end
        end
      else
        decode_value(outputs_spec[0]["type"], outputs[0])
      end
    end

    def decode_value(type, value)
      decoded_value = @@decoding[type].call(value)
      raise "Unable to decode type: #{type}" if decoded_value.nil?
      decoded_value
    end

    #This will probably work for all uints
    @@decoding["uint256"] = fn do |value|
      value.to_i(16)
    end

    @@decoding["bytes32"] = fn do |value|
      [value].pack('H*').strip
    end

    @@decoding["bool"] = fn do |value|
      value[-1].to_i ? true : false
    end

  end
end