require 'w3'
require 'speculation'

S.check_asserts = true

RSpec.describe W3::ETH_Type do
  context "testing out ETH_Type specs" do

    range_of_ints = (8..256).select {|x| x % 8 == 0}

    range_of_ints.each do |n|
      it "checks W3::ETH_Type/uint#{n} spec" do
        uint_spec_name = "W3::ETH_Type/uint#{n}".to_sym
        S.assert(uint_spec_name, 42)
        expect(S.invalid?(S.conform(uint_spec_name, "42"))).to eq true
        expect(S.invalid?(S.conform(uint_spec_name, -1))).to eq true
        expect(S.invalid?(S.conform(uint_spec_name, 2.0))).to eq true
        expect(S.invalid?(S.conform(uint_spec_name, nil))).to eq true
        expect(S.invalid?(S.conform(uint_spec_name, 2 ** n + 1))).to eq true
      end

      it "checks W3::ETH_Type/int#{n} spec" do
        int_spec_name = "W3::ETH_Type/int#{n}".to_sym
        S.assert(int_spec_name, 42)
        S.assert(int_spec_name, -42)
        expect(S.invalid?(S.conform(int_spec_name, "42"))).to eq true
        expect(S.invalid?(S.conform(int_spec_name, 2.0))).to eq true
        expect(S.invalid?(S.conform(int_spec_name, nil))).to eq true
        expect(S.invalid?(S.conform(int_spec_name, 2 ** n + 1))).to eq true
        expect(S.invalid?(S.conform(int_spec_name, -1 * (2 ** n + 1)))).to eq true
      end
    end

    it "checks W3::ETH_Type/uint spec" do
      S.assert(:"W3::ETH_Type/uint", 42)
      expect(S.invalid?(S.conform(:"W3::ETH_Type/uint", 2 ** 256 + 1)))
    end

    it "checks W3::ETH_Type/int spec" do
      S.assert(:"W3::ETH_Type/int", 42)
      S.assert(:"W3::ETH_Type/int", -42)
      expect(S.invalid?(S.conform(:"W3::ETH_Type/int", 2 ** 256 + 1)))
      expect(S.invalid?(S.conform(:"W3::ETH_Type/int", -1 * (2 ** 256 + 1))))
    end

    (1..32).each do |n|
      it "checks W3::ETH_Type/bytes#{n} spec" do
      bytes_spec_name = "W3::ETH_Type/bytes#{n}".to_sym
      test_str = "".tap do |s|
        (n*2).times do
          s << "a"
        end
      end

      S.assert(bytes_spec_name, test_str)
      test_str << "a"
      expect(S.invalid?(S.conform(bytes_spec_name, test_str))).to eq true
      end
    end

    it "checks W3::ETH_Type/bool spec" do
      S.assert(:"W3::ETH_Type/bool", true)
      S.assert(:"W3::ETH_Type/bool", false)
      expect(S.invalid?(S.conform(:"W3::ETH_Type/bool", "true"))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/bool", 0))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/bool", 1))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/bool", nil))).to eq true
    end

    it "checks W3::ETH_Type/address spec" do
      S.assert(:"W3::ETH_Type/address", "0x0fad53edb3f5b309c30c67f2bd64f10f505de0cb")
      expect(S.invalid?(S.conform(:"W3::ETH_Type/address", "0fad53edb3f5b309c30c67f2bd64f10f505de0cb"))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/address", "0x0fad53edb3f5b309c30c67f2bd64f10f505de0"))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/address", "0x0fad53edb3f5b309c30c67f2bd64f10f505de0cb4"))).to eq true
    end

    it "checks W3::ETH_Type/bytes spec" do
      S.assert(:"W3::ETH_Type/bytes", "Hello, world")
      expect(S.invalid?(S.conform(:"W3::ETH_Type/bytes", nil))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/bytes", ""))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/bytes", 42))).to eq true
    end

    it "checks W3::ETH_Type/string spec" do
      S.assert(:"W3::ETH_Type/string", "Hello, world")
      expect(S.invalid?(S.conform(:"W3::ETH_Type/string", nil))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/string", ""))).to eq true
      expect(S.invalid?(S.conform(:"W3::ETH_Type/string", 42))).to eq true
    end

    it "checks array types" do
      S.assert(:"W3::ETH_Type/uint_array", [1, 2, 3])
      S.assert(:"W3::ETH_Type/int_array", [-1, 2, -3])
      S.assert(:"W3::ETH_Type/bool_array", [true, false, true])
      S.assert(:"W3::ETH_Type/bytes32_array", ["foo", "bar", "foobar"])
      S.assert(:"W3::ETH_Type/bytes_array", ["foo", "bar", "foobar"])
      S.assert(:"W3::ETH_Type/string_array", ["foo", "bar", "foobar"])
    end
  end
end