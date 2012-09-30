require 'spec_helper'

describe Base::Generators::NumberGteVariable do
  describe '#number_of_outputs' do
    context 'ternary' do
      it 'returns correct number of output digits needed to count 1,2' do
        described_class.new(%w(a b), :target => 2).number_of_outputs.should == 1
        described_class.new(%w(a b c), :target => 2).number_of_outputs.should == 1
        described_class.new(('a'..'f').to_a, :target => 2).number_of_outputs.should == 1
        described_class.new((1..8).to_a, :target => 2).number_of_outputs.should == 1
        described_class.new((1..9).to_a, :target => 2).number_of_outputs.should == 1
      end
    end

    context 'base 4' do
      it 'returns correct number of output digits needed to count 1,2,3' do
        described_class.new(%w(a b), :radix => 4, :target => 2).number_of_outputs.should == 1
        described_class.new(%w(a b c), :radix => 4, :target => 2).number_of_outputs.should == 1
        described_class.new(%w(a b c d), :radix => 4, :target => 2).number_of_outputs.should == 1
        described_class.new(('a'..'f').to_a, :radix => 4, :target => 2).number_of_outputs.should == 1
        described_class.new((1..15).to_a, :radix => 4, :target => 2).number_of_outputs.should == 1
        described_class.new((1..16).to_a, :radix => 4, :target => 2).number_of_outputs.should == 1
      end
    end
  end


  describe '#signature' do
    it 'returns proper signature based on radix, number of digits and variable' do
      described_class.new(%w(a b), :radix => 3, :target => 2).signature.should == "3-2gtev2"
      described_class.new(%w(a b c), :radix => 4, :target => 3).signature.should == "4-3gtev3" 
      described_class.new(%w(a b c d), :radix => 6, :target => 4).signature.should == "6-4gtev4"
      described_class.new(('a'..'f').to_a, :radix => 4, :target => 5).signature.should == "4-6gtev5"
      described_class.new((1..15).to_a, :radix => 4, :target => 11).signature.should == "4-15gtev11"
    end
  end

  describe '#specification' do
    context "ternary" do
      it "generates specification for 3 variables" do
        generator = described_class.new(%w(a b c), :radix => 3, :target => 2)
        expected =  [
          "00000 1", "00100 1", "00200 1", "01000 1", "01100 1", "01200 1", "02000 1", "02100 1", "02200 1", 
          "10000 1", "10100 1", "10200 1", "11000 1", "11100 1", "11200 1", "12000 1", "12100 1", "12200 1", 
          "20000 1", "20100 1", "20200 1", "21000 1", "21100 1", "21200 1", "22000 1", "22100 1", "22200 1", 

          "00001 0", "00101 1", "00201 1", "01001 1", "01101 1", "01201 1", "02001 1", "02101 1", "02201 1", 
          "10001 1", "10101 1", "10201 1", "11001 1", "11101 1", "11201 1", "12001 1", "12101 1", "12201 1", 
          "20001 1", "20101 1", "20201 1", "21001 1", "21101 1", "21201 1", "22001 1", "22101 1", "22201 1", 

          "00002 0", "00102 0", "00202 1", "01002 1", "01102 1", "01202 1", "02002 1", "02102 1", "02202 1", 
          "10002 1", "10102 1", "10202 1", "11002 1", "11102 1", "11202 1", "12002 1", "12102 1", "12202 1", 
          "20002 1", "20102 1", "20202 1", "21002 1", "21102 1", "21202 1", "22002 1", "22102 1", "22202 1", 

          "00010 0", "00110 0", "00210 0", "01010 1", "01110 1", "01210 1", "02010 1", "02110 1", "02210 1", 
          "10010 1", "10110 1", "10210 1", "11010 1", "11110 1", "11210 1", "12010 1", "12110 1", "12210 1", 
          "20010 1", "20110 1", "20210 1", "21010 1", "21110 1", "21210 1", "22010 1", "22110 1", "22210 1", 

          "00011 0", "00111 0", "00211 0", "01011 0", "01111 1", "01211 1", "02011 1", "02111 1", "02211 1", 
          "10011 1", "10111 1", "10211 1", "11011 1", "11111 1", "11211 1", "12011 1", "12111 1", "12211 1", 
          "20011 1", "20111 1", "20211 1", "21011 1", "21111 1", "21211 1", "22011 1", "22111 1", "22211 1", 
          
          "00012 0", "00112 0", "00212 0", "01012 0", "01112 0", "01212 1", "02012 1", "02112 1", "02212 1", 
          "10012 1", "10112 1", "10212 1", "11012 1", "11112 1", "11212 1", "12012 1", "12112 1", "12212 1", 
          "20012 1", "20112 1", "20212 1", "21012 1", "21112 1", "21212 1", "22012 1", "22112 1", "22212 1", 

          "00020 0", "00120 0", "00220 0", "01020 0", "01120 0", "01220 0", "02020 1", "02120 1", "02220 1", 
          "10020 1", "10120 1", "10220 1", "11020 1", "11120 1", "11220 1", "12020 1", "12120 1", "12220 1", 
          "20020 1", "20120 1", "20220 1", "21020 1", "21120 1", "21220 1", "22020 1", "22120 1", "22220 1", 

          "00021 0", "00121 0", "00221 0", "01021 0", "01121 0", "01221 0", "02021 0", "02121 1", "02221 1", 
          "10021 1", "10121 1", "10221 1", "11021 1", "11121 1", "11221 1", "12021 1", "12121 1", "12221 1", 
          "20021 1", "20121 1", "20221 1", "21021 1", "21121 1", "21221 1", "22021 1", "22121 1", "22221 1", 

          "00022 0", "00122 0", "00222 0", "01022 0", "01122 0", "01222 0", "02022 0", "02122 0", "02222 1", 
          "10022 1", "10122 1", "10222 1", "11022 1", "11122 1", "11222 1", "12022 1", "12122 1", "12222 1", 
          "20022 1", "20122 1", "20222 1", "21022 1", "21122 1", "21222 1", "22022 1", "22122 1", "22222 1"
          ]
        generator.specification.should == expected
      end
    end
  end
end

