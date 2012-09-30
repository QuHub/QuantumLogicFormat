require 'spec_helper'

describe Base::Generators::NumberGteConstant do
  describe '#number_of_outputs' do
    context 'ternary' do
      it 'returns correct number of output digits needed to count 1,2' do
        described_class.new(%w(a b), :constant => 10).number_of_outputs.should == 1
        described_class.new(%w(a b c), :constant => 10).number_of_outputs.should == 1
        described_class.new(('a'..'f').to_a, :constant => 10).number_of_outputs.should == 1
        described_class.new((1..8).to_a, :constant => 10).number_of_outputs.should == 1
        described_class.new((1..9).to_a, :constant => 10).number_of_outputs.should == 1
      end
    end

    context 'base 4' do
      it 'returns correct number of output digits needed to count 1,2,3' do
        described_class.new(%w(a b), :radix => 4, :constant => 10).number_of_outputs.should == 1
        described_class.new(%w(a b c), :radix => 4, :constant => 10).number_of_outputs.should == 1
        described_class.new(%w(a b c d), :radix => 4, :constant => 10).number_of_outputs.should == 1
        described_class.new(('a'..'f').to_a, :radix => 4, :constant => 10).number_of_outputs.should == 1
        described_class.new((1..15).to_a, :radix => 4, :constant => 10).number_of_outputs.should == 1
        described_class.new((1..16).to_a, :radix => 4, :constant => 10).number_of_outputs.should == 1
      end
    end
  end


  describe '#signature' do
    it 'returns proper signature based on radix, number of digits and constant' do
      described_class.new(%w(a b), :radix => 3, :constant => 10).signature.should == "3-2gte10"
      described_class.new(%w(a b c), :radix => 4, :constant => 12).signature.should == "4-3gte12" 
      described_class.new(%w(a b c d), :radix => 6, :constant => 19).signature.should == "6-4gte19"
      described_class.new(('a'..'f').to_a, :radix => 4, :constant => 11).signature.should == "4-6gte11"
      described_class.new((1..15).to_a, :radix => 4, :constant => 9).signature.should == "4-15gte9"
    end
  end

  describe '#specification' do
    context "ternary" do
      it "generates specification for 3 variables" do
        generator = described_class.new(%w(a b c), :radix => 3, :constant => 10)
        expected =  [
         "000 0", "001 0", "002 0", 
         "010 0", "011 0", "012 0", 
         "020 0", "021 0", "022 0", 
         "100 0", "101 1", "102 1", 
         "110 1", "111 1", "112 1", 
         "120 1", "121 1", "122 1", 
         "200 1", "201 1", "202 1", 
         "210 1", "211 1", "212 1", 
         "220 1", "221 1", "222 1"
         ] 
        generator.specification.should == expected
      end

      it "generates specification for 4 variables" do
        generator = described_class.new(%w(a b c d), :radix => 3, :constant => 15)
        expected = [
          "0000 0", "0001 0", "0002 0", 
          "0010 0", "0011 0", "0012 0", 
          "0020 0", "0021 0", "0022 0", 
          "0100 0", "0101 0", "0102 0", 
          "0110 0", "0111 0", "0112 0", 
          "0120 1", "0121 1", "0122 1", 
          "0200 1", "0201 1", "0202 1", 
          "0210 1", "0211 1", "0212 1", 
          "0220 1", "0221 1", "0222 1", 
          "1000 1", "1001 1", "1002 1", 
          "1010 1", "1011 1", "1012 1", 
          "1020 1", "1021 1", "1022 1", 
          "1100 1", "1101 1", "1102 1", 
          "1110 1", "1111 1", "1112 1", 
          "1120 1", "1121 1", "1122 1", 
          "1200 1", "1201 1", "1202 1", 
          "1210 1", "1211 1", "1212 1", 
          "1220 1", "1221 1", "1222 1", 
          "2000 1", "2001 1", "2002 1", 
          "2010 1", "2011 1", "2012 1", 
          "2020 1", "2021 1", "2022 1", 
          "2100 1", "2101 1", "2102 1", 
          "2110 1", "2111 1", "2112 1", 
          "2120 1", "2121 1", "2122 1", 
          "2200 1", "2201 1", "2202 1", 
          "2210 1", "2211 1", "2212 1", 
          "2220 1", "2221 1", "2222 1"
          ]
        
        generator.specification.should == expected
      end
    end
  end
end

describe Base::Generators::NumberGte10 do
  describe '#signature' do
    it 'returns proper signature based on radix, number of digits and constant' do
      described_class.new(%w(a b), :radix => 3).signature.should == "3-2gte10"
      described_class.new(%w(a b c), :radix => 4).signature.should == "4-3gte10" 
      described_class.new(%w(a b c d), :radix => 6).signature.should == "6-4gte10"
      described_class.new(('a'..'f').to_a, :radix => 4).signature.should == "4-6gte10"
      described_class.new((1..15).to_a, :radix => 4).signature.should == "4-15gte10"
    end
  end
end
