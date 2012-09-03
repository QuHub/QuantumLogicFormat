require 'spec_helper'

describe Digit do
  subject {Digit.new(100, 3)}
  describe '#=' do
    it 'assigns string values' do
      subject.should == '100' 
      subject = '200'
      subject.should == '200' 
    end

    it 'assigns integer looking values' do
      subject.should == 100 
      subject = 200
      subject.should == 200 
    end
  end

  describe '#unshift' do
    it 'inserts the digit(s) on the left side of the number' do
      subject.unshift(3).should == 3100
      subject.unshift(999).should == 9993100
      subject.unshift('000').should == '0009993100'
    end
  end

  describe '#push' do
    it 'inserts the digit(s) on the left side of the number' do
      subject.push(3).should == 1003
      subject.push(999).should == 1003999
      subject.push('000').should == 1003999000
    end
  end
end


