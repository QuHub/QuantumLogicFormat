require 'spec_helper'

describe Base::Generators::Reflection do
  describe "#generate" do
    it "generates reflection for 2 variables" do
      generator = described_class.new(%w(a b))
      expected = ['t2 a b', 'p12 a', 't2 b a', 't2 a b', 't2 a b']
    #  generator.generate.should == expected
    end
  end


  describe "#feynman_ladder" do
    it "generates n-1 ladder of feynman gates in a ladder pattern" do
      generator = Base::Generators::Reflection.new(%w(a b))
    #  generator.feynman_ladder.should == ['']
    end
  end

  describe '#specification' do
    context "ternary" do
      it "generates specification for 2 variables" do
        generator = described_class.new(%w(a b), :radix => 3)
        expected = ['00 00', '01 10', '02 20', '10 01', '11 11', '12 21', '20 02', '21 12', '22 22']
        generator.specification.should == expected
      end

      it "generates specification for 3 variables" do
        generator = described_class.new(%w(a b c), :radix => 3)
        expected = [
          '000 000', '001 100', '002 200', '010 010', '011 110', '012 210', '020 020', '021 120', '022 220',
          '100 001', '101 101', '102 201', '110 011', '111 111', '112 211', '120 021', '121 121', '122 221',
          '200 002', '201 102', '202 202', '210 012', '211 112', '212 212', '220 022', '221 122', '222 222'
        ]
        generator.specification.should == expected
      end
    end

    context "quartenary" do
      it "generates specification for 2 variables" do
        generator = described_class.new(%w(a b), :radix => 4)
        expected = ['00 00', '01 10', '02 20', '03 30', 
                    '10 01', '11 11', '12 21', '13 31', 
                    '20 02', '21 12', '22 22', '23 32', 
                    '30 03', '31 13', '32 23', '33 33' ]
        generator.specification.should == expected
      end
    end
  end
end
