module W3
  module ETH_Type
    extend S::NamespacedSymbols
  
    S.def ns(:integer), Integer
    S.def ns(:positive_integer), ->(x){x >= 0}
  
    range_of_ints = (8..256).select {|x| x % 8 == 0}
    range_of_ints.each do |n|
      uint_spec_name = "W3::ETH_Type/uint#{n}".to_sym
      S.def uint_spec_name, S.and(ns(:integer), S.and(ns(:positive_integer), ->(x){x < 2 ** n}))
  
      S.def "W3::ETH_Type/uint#{n}_array".to_sym, S.coll_of(uint_spec_name)
  
      int_spec_name = "W3::ETH_Type/int#{n}".to_sym
      S.def int_spec_name, S.and(ns(:integer), ->(x){ x > -1 * (2 ** n) && x < 2 ** n})
  
      S.def "W3::ETH_Type/int#{n}_array".to_sym, S.coll_of(int_spec_name)
    end
  
    S.def ns(:uint), S.and(ns(:integer), S.and(ns(:positive_integer), ns(:uint256)))
    S.def ns(:int), S.and(ns(:integer), ns(:int256))
  
    S.def ns(:uint_array), S.coll_of(ns(:uint))
    S.def ns(:int_array), S.coll_of(ns(:int))
  
    (1..32).each do |n|
      bytes_spec_name = "W3::ETH_Type/bytes#{n}".to_sym
      S.def bytes_spec_name, S.and(String, ->(x){ x.bytesize > 0 && x.bytesize <= n * 2 })
  
      S.def "W3::ETH_Type/bytes#{n}_array".to_sym, S.coll_of(bytes_spec_name)
    end
  
    S.def ns(:bool), ->(x){x == true || x == false}
    S.def ns(:bool_array), S.coll_of(ns(:bool))
    
    S.def :"W3::ETH_Type/0x", ->(x){x[0..1] == "0x"}
    S.def ns(:address_length), ->(x){x[1..-1].bytesize == 20 * 2}
    S.def ns(:address), S.and(:"W3::ETH_Type/0x", ns(:address_length))
    S.def ns(:address_array), S.coll_of(ns(:address))
  
    S.def :"W3::ETH_Type/utf-8", ->(x){x.encoding.to_s == "UTF-8"}
    S.def ns(:bytes), String
    S.def ns(:string), S.and(String, :"W3::ETH_Type/utf-8")
  
    S.def ns(:bytes_array), S.coll_of(ns(:bytes))
    S.def ns(:string_array), S.coll_of(ns(:string))
  end
end