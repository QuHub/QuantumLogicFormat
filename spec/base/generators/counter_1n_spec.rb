require 'spec_helper'

describe Base::Generators::Counter1n do
  describe '#number_of_outputs' do
    context 'ternary' do
      it 'returns correct number of output digits needed to count 1,2' do
        described_class.new(%w(a b)).number_of_outputs.should == 2
        described_class.new(%w(a b c)).number_of_outputs.should == 4
        described_class.new(('a'..'f').to_a).number_of_outputs.should == 4
        described_class.new((1..8).to_a).number_of_outputs.should == 4
        described_class.new((1..9).to_a).number_of_outputs.should == 6
      end
    end

    context 'base 4' do
      it 'returns correct number of output digits needed to count 1,2,3' do
        described_class.new(%w(a b), :radix => 4).number_of_outputs.should == 3
        described_class.new(%w(a b c), :radix => 4).number_of_outputs.should == 3
        described_class.new(%w(a b c d), :radix => 4).number_of_outputs.should == 6
        described_class.new(('a'..'f').to_a, :radix => 4).number_of_outputs.should == 6
        described_class.new((1..15).to_a, :radix => 4).number_of_outputs.should == 6
        described_class.new((1..16).to_a, :radix => 4).number_of_outputs.should == 9
      end
    end
  end

  describe '#count_of_digits' do
    context 'ternary' do
      subject {described_class.new((1..10).to_a) }

      it 'returns count of digits' do
        subject.count_of_digits('0112011121').should == '002020'  # 2 twos, 6 ones
        subject.count_of_digits('2222222222').should == '101000'  # 10 twos, 0 ones
        subject.count_of_digits('1111111111').should == '000101'  # 0 twos, 10 ones
        subject.count_of_digits('0').should == '000000'  
        subject.count_of_digits('00121120').should == '002010'
      end
    end

    context 'base 4' do
      subject {described_class.new((1..10).to_a, :radix => 4) }

      it 'returns count of digits' do
        subject.count_of_digits('3112011121').should == '010212'  # 1 three, 2 twos, 6 ones
        subject.count_of_digits('2222222222').should == '002200'  
        subject.count_of_digits('1111111111').should == '000022'  
        subject.count_of_digits('3333333333').should == '220000'  
        subject.count_of_digits('0').should == '000000'  
        subject.count_of_digits('00121120').should == '000203' 
      end
    end
  end

  describe '#specification' do
    context "ternary" do
      it "generates specification for 3 variables" do
        generator = described_class.new(%w(a b c), :radix => 3)
        expected =  [
         "000 0000", "001 0001", "002 0100", 
         "010 0001", "011 0002", "012 0101", 
         "020 0100", "021 0101", "022 0200", 
         "100 0001", "101 0002", "102 0101", 
         "110 0002", "111 0010", "112 0102", 
         "120 0101", "121 0102", "122 0201", 
         "200 0100", "201 0101", "202 0200", 
         "210 0101", "211 0102", "212 0201", 
         "220 0200", "221 0201", "222 1000"
         ] 
        generator.specification.should == expected
      end

      it "generates specification for 4 variables" do
        generator = described_class.new(%w(a b c d), :radix => 3)
        expected = [
          "0000 0000", "0001 0001", "0002 0100", 
          "0010 0001", "0011 0002", "0012 0101", 
          "0020 0100", "0021 0101", "0022 0200", 
          "0100 0001", "0101 0002", "0102 0101", 
          "0110 0002", "0111 0010", "0112 0102", 
          "0120 0101", "0121 0102", "0122 0201", 
          "0200 0100", "0201 0101", "0202 0200", 
          "0210 0101", "0211 0102", "0212 0201", 
          "0220 0200", "0221 0201", "0222 1000", 
          "1000 0001", "1001 0002", "1002 0101", 
          "1010 0002", "1011 0010", "1012 0102", 
          "1020 0101", "1021 0102", "1022 0201", 
          "1100 0002", "1101 0010", "1102 0102", 
          "1110 0010", "1111 0011", "1112 0110", 
          "1120 0102", "1121 0110", "1122 0202", 
          "1200 0101", "1201 0102", "1202 0201", 
          "1210 0102", "1211 0110", "1212 0202", 
          "1220 0201", "1221 0202", "1222 1001", 
          "2000 0100", "2001 0101", "2002 0200", 
          "2010 0101", "2011 0102", "2012 0201", 
          "2020 0200", "2021 0201", "2022 1000", 
          "2100 0101", "2101 0102", "2102 0201", 
          "2110 0102", "2111 0110", "2112 0202", 
          "2120 0201", "2121 0202", "2122 1001", 
          "2200 0200", "2201 0201", "2202 1000", 
          "2210 0201", "2211 0202", "2212 1001", 
          "2220 1000", "2221 1001", "2222 1100"
          ]
        
        generator.specification.should == expected
      end
    end
  end
end
