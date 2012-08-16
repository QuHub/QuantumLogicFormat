require 'spec_helper'

describe Base::Configuration do
  let(:filename){File.expand_path('../../fixtures/ternary.qlf', __FILE__)}
  subject {Base::Configuration.new(filename)}

  describe '#parse' do
    it 'sets default radix' do
      subject.default.radix.should == 3
    end

    it 'sets number of input variables' do
      subject.inputs.variables.should == 3
    end

    it 'sets number of output variables' do
      subject.outputs.variables.should == 3
    end

    it 'load specification' do
      subject.specification.should be_an_instance_of Base::Specification 
    end
  end

end
