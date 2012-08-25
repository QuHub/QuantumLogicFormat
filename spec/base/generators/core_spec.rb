require 'spec_helper'

describe Base::Generators::Core do
  describe "#to_radix" do
    1.upto(10).each do |n| 
      it "converts #{n} single digit variable decimal number to their ternary represnetation" do
        generator = described_class.new(n, :radix => 3)
        generator.to_radix(1).should == "%0#{n}d" % 1
        generator.to_radix(2).should == "%0#{n}d" % 2
      end
    end

    2.upto(10).each do |n| 
      it "converts #{n} double digit variable decimal number to their ternary represnetation" do
        generator = described_class.new(n, :radix => 3)
        generator.to_radix(3).should == "%0#{n}d" % 10
        generator.to_radix(6).should == "%0#{n}d" % 20
        generator.to_radix(7).should == "%0#{n}d" % 21
        generator.to_radix(8).should == "%0#{n}d" % 22
      end
    end

    3.upto(10).each do |n| 
      it "converts #{n} double digit variable decimal number to their ternary represnetation" do
        generator = described_class.new(n, :radix => 3)
        generator.to_radix(9).should  == "%0#{n}d" % 100
        generator.to_radix(10).should == "%0#{n}d" % 101
        generator.to_radix(20).should == "%0#{n}d" % 202
        generator.to_radix(26).should == "%0#{n}d" % 222
      end
    end
  end
end
