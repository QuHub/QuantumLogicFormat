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

    it 'doubles input size for every new input variable' do
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

    it 'left inserts 00, 01, 10, 11 for 2 variables' do
      subject.stub(:variables_to_complete_inputs => 2)  
      subject.expand_inputs(inputs).should == ["0000", "0001", "0002", "0003", "0100", "0101", "0102", "0103", "1000", "1001", "1002", "1003", "1100", "1101", "1102", "1103"]
    end
  end

  describe '#expand_outputs' do
    let(:outputs) { ['00', '01', '02', '03'].map{|x| Digit.new(x)} }

    it 'doubles output size for every new input variable' do
      subject.stub(:variables_to_complete_inputs => 1)  
      subject.expand_outputs(outputs).should have(8).items

      subject.stub(:variables_to_complete_inputs => 2)  
      subject.expand_outputs(outputs).should have(16).items

      subject.stub(:variables_to_complete_inputs => 3)  
      subject.expand_outputs(outputs).should have(32).items
    end

    it 'duplicates the inital output array' do
      subject.stub(:variables_to_complete_inputs => 1)  
      subject.expand_outputs(outputs).should == ["00", "01", "02", "03","00", "01", "02", "03"] 

      subject.stub(:variables_to_complete_inputs => 2)  
      subject.expand_outputs(outputs).should == ["00", "01", "02", "03","00", "01", "02", "03", "00", "01", "02", "03","00", "01", "02", "03"] 
    end
  end

  describe '#complete_outputs' do
    it 'completes the outputs ot have unique minterms for a reversible function' do

    end
  end

  pending '#hamming_distance' do
    let(:inputs) { ['10', '01', '02', '03'].map{|x| Digit.new(x)} }
    let(:outputs) { ['2100', '0101', '1002', '0003'].map{|x| Digit.new(x)} }

    it 'calcualtes the best hamming distance for each digit in output to all digits in input' do
      subject.hamming_distance(inputs, outputs).should == [[[0, 0], [1, 3], [2, 3], [3, 4]], [[0, 4], [1, 1], [2, 1], [3, 2]]] 
    end
  end

  describe '#terms_for' do
    it 'returns list of terms for the specificied number of variables and radix' do
      subject.terms_for(4, 2).should == ["0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"] 
      subject.terms_for(3, 3).should == ["000", "001", "002", "010", "011", "012", "020", "021", "022", "100", "101", "102", "110", "111", "112", "120", "121", "122", "200", "201", "202", "210", "211", "212", "220", "221", "222"]
      subject.terms_for(2, 4).should == ["00", "01", "02", "03", "10", "11", "12", "13", "20", "21", "22", "23", "30", "31", "32", "33"]
    end
  end

  describe '#to_vectors' do
    it 'separates digits of an array of strigs (of digist)' do
      subject.to_vectors(['123', '456', '789']).should == [[3,6,9], [2,5,8], [1,4,7]]
    end
  end

end
