require 'w3'
require 'speculation'

S.check_asserts = true

RSpec.describe W3::ETH_Type do
  context "testing out ETH_Type spec" do

    it 'checks for invalid uint' do
      S.assert(:"W3::ETH_Type/uint", 42)
      expect(S.invalid?(S.conform(:"W3::ETH_Type/uint", 2 ** 256 + 1)))
    end

    it 'checks for invalid int' do
      S.assert(:"W3::ETH_Type/int", 42)
      S.assert(:"W3::ETH_Type/int", -42)
      expect(S.invalid?(S.conform(:"W3::ETH_Type/int", 2 ** 256 + 1)))
      expect(S.invalid?(S.conform(:"W3::ETH_Type/int", -1 * (2 ** 256 + 1))))
    end

    range_of_ints = (8..256).select {|x| x % 8 == 0}

    range_of_ints.each do |n|
      it "checks for invalid uint#{n}" do
        uint_spec_name = "W3::ETH_Type/uint#{n}".to_sym
        S.assert(uint_spec_name, 42)
        expect(S.invalid?(S.conform(uint_spec_name, "42")))
        expect(S.invalid?(S.conform(uint_spec_name, -1)))
        expect(S.invalid?(S.conform(uint_spec_name, 2.0)))
        expect(S.invalid?(S.conform(uint_spec_name, nil)))
        expect(S.invalid?(S.conform(uint_spec_name, 2 ** n + 1)))
      end

      it "checks for invalid int#{n}" do
        int_spec_name = "W3::ETH_Type/int#{n}".to_sym
        S.assert(int_spec_name, 42)
        S.assert(int_spec_name, -42)
        expect(S.invalid?(S.conform(int_spec_name, "42")))
        expect(S.invalid?(S.conform(int_spec_name, 2.0)))
        expect(S.invalid?(S.conform(int_spec_name, nil)))
        expect(S.invalid?(S.conform(int_spec_name, 2 ** n + 1)))
        expect(S.invalid?(S.conform(int_spec_name, -1 * (2 ** n + 1))))
      end
    end

  end
end