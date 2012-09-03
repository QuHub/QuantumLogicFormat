require 'spec_helper'

describe Base::Transformers::Bijector do

  describe '#complete' do
  end

end

# private methods
describe_internally Base::Transformers::Bijector do
  let(:configuration) { build :configuration, :filename => 'full_adder_3.qlf'}
  let(:specification) {build :specification, configuration: configuration }
  subject {described_class.new(specification)}

  describe '#variables_to_complete_output' do
    it "calcs the number of bits needed the function" do
      subject.variables_to_complete_output.should == 2
    end
  end

  describe '#expand_inputs' do
    let(:inputs) { ['00', '01', '02', '03'].map{|x| Digit.new(x)} }

    it 'doubles input size for every variable' do
      subject.stub(:variables_to_complete_inputs => 1)  
      subject.expand_inputs(inputs).should have(8).items

      subject.stub(:variables_to_complete_inputs => 2)  
      subject.expand_inputs(inputs).should have(16).items

      subject.stub(:variables_to_complete_inputs => 3)  
      subject.expand_inputs(inputs).should have(32).items
    end

    it 'left inserts a 0 for the first half of the doubled list' do
      subject.stub(:variables_to_complete_inputs => 1)  
      subject.expand_inputs(inputs)[0..3].should == ["000", "001", "002", "003"] 
    end

    it 'left inserts a 1 for the first half of the doubled list' do
      subject.stub(:variables_to_complete_inputs => 1)  
      subject.expand_inputs(inputs)[4..7].should == ["100", "101", "102", "103"] 
    end

    it 'left 00, 01, 10, 11 for 2 variables' do
      subject.stub(:variables_to_complete_inputs => 2)  
      subject.expand_inputs(inputs).should == ["0000", "0001", "0002", "0003", "0100", "0101", "0102", "0103", "1000", "1001", "1002", "1003", "1100", "1101", "1102", "1103"]
    end
  end
end
