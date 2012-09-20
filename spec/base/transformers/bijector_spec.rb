require 'spec_helper'

describe Base::Transformers::Bijector do
  let(:yaml) { File.open(fixture_path('full_adder_3.qlf')).read}
  subject {described_class.new(yaml)}

  describe '#complete' do
    it 'returns inputs and outputs of complete specification' do
      spec = YAML.load subject.complete
      spec['specification'].split("\n").should == [
        "0000 0000", "0001 0001", "0002 0002", 
        "0010 0101", "0011 0102", "0012 0010", 
        "0020 0202", "0021 0110", "0022 0011", 
        "0100 0201", "0101 1002", "0102 0210", 
        "0110 1102", "0111 1010", "0112 0111", 
        "0120 1110", "0121 0211", "0122 0012", 
        "0200 1202", "0201 1210", "0202 1011", 
        "0210 2010", "0211 1111", "0212 0112", 
        "0220 1211", "0221 0212", "0222 0020"
      ]
    end
  end
end

# private methods
describe_internally Base::Transformers::Bijector do
  let(:yaml) { File.open(fixture_path('full_adder_3.qlf')).read}
  subject {described_class.new(yaml)}

  describe '#variables_to_complete_output' do
    it "calcs the number of bits needed the function" do
      subject.variables_to_complete_output.should == 2
    end
  end

  describe '#expand_inputs' do
    let(:inputs) { ['00', '01', '02', '03'].map{|x| Digit.new(x)} }

    it 'doubles input size for every new input variable' do
      subject.stub(:variables_to_complete_input => 1)  
      subject.expand_inputs(inputs).should have(4).items

      subject.stub(:variables_to_complete_input => 2)  
      subject.expand_inputs(inputs).should have(4).items

      subject.stub(:variables_to_complete_input => 3)  
      subject.expand_inputs(inputs).should have(4).items
    end

    it 'left inserts a 0 for the list' do
      subject.stub(:variables_to_complete_input => 1)  
      subject.expand_inputs(inputs).should == ["000", "001", "002", "003"] 
    end

    it 'left inserts 00, 01, 10, 11 for 2 variables' do
      subject.stub(:variables_to_complete_input => 2)  
      subject.expand_inputs(inputs).should == ["0000", "0001", "0002", "0003"]
    end
  end

  describe '#expand_outputs' do
    let(:outputs) { ['00', '01', '02', '03'].map{|x| Digit.new(x)} }

    it 'doubles output size for every new input variable' do
      subject.stub(:variables_to_complete_input => 1)  
      subject.expand_outputs(outputs).should have(8).items

      subject.stub(:variables_to_complete_input => 2)  
      subject.expand_outputs(outputs).should have(16).items

      subject.stub(:variables_to_complete_input => 3)  
      subject.expand_outputs(outputs).should have(32).items
    end

    it 'duplicates the inital output array' do
      subject.stub(:variables_to_complete_input => 1)  
      subject.expand_outputs(outputs).should == ["00", "01", "02", "03","00", "01", "02", "03"] 

      subject.stub(:variables_to_complete_input => 2)  
      subject.expand_outputs(outputs).should == ["00", "01", "02", "03","00", "01", "02", "03", "00", "01", "02", "03","00", "01", "02", "03"] 
    end
  end

  describe '#complete_outputs' do
    # The output is completed such that each output pattern can have a unique mapping with the input.
    # We usually have to add additional input digits, which will be set to a constant, and hence,
    # we don't need to list all possible minterms on the input side, just the ones for that constant.
    it 'completes the output for the minterms so that each minterm maps uniquely from input to output with the same number of bits' do
      subject.stub(:total_variables => 3)
      outputs = ['00', '01', '01', '02', '11', '01', '00', '12']
      subject.complete_outputs(outputs).should == ['000', '001', '101', '002', '011', '201', '100', '012']

      subject.stub(:total_variables => 4)
      outputs = ['00', '01', '01', '02', '11', '01', '00', '12']
      subject.complete_outputs(outputs).should == ['0000', '0001', '0101', '0002', '0011', '0201', '0100', '0012']
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
