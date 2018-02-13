require 'w3'

S.check_asserts = true

RSpec.describe W3::Decoder do

  context "decoder being checked against evm_types spec" do

    W3::ETH_Type::range_of_ints.each do |n|
      it "decodes uint#{n}" do
        good_uint = "0x" + (2 ** n - 1).to_s(16)
        bad_uint = "0x" + (2 ** n).to_s(16)
        uint_spec_name = "W3::ETH_Type/uint#{n}".to_sym
        S.assert uint_spec_name, W3::Decoder::decode_value("uint#{n}", good_uint)
        expect(S.invalid?(S.conform(uint_spec_name, bad_uint))).to eq true
      end

      it "decodes int#{n}" do
        good_int = "0x" + (2 ** n - 1).to_s(16)
        good_neg_int = "0x" + (-1 * (2 ** n - 1)).to_s(16)
        bad_int = "0x" + (2 ** n).to_s(16)
        uint_spec_name = "W3::ETH_Type/int#{n}".to_sym
        S.assert uint_spec_name, W3::Decoder::decode_value("int#{n}", good_int)
        S.assert uint_spec_name, W3::Decoder::decode_value("int#{n}", good_neg_int)
        expect(S.invalid?(S.conform(uint_spec_name, bad_int))).to eq true
      end
    end

    # W3::ETH_Type::range_of_bytes.each do |n|
    #   it "decodes bool #{n}" do
    #   end
    # end
  end
end