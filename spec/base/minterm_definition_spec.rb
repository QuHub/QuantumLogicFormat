require 'spec_helper'

describe MintermDefinition do
  describe "#radix_mask" do
    context 'a single radix is given' do
      subject {MintermDefinition.new({'radix' => 3, 'variables' => 10}) }

      it "returns a radix mask representing each digit" do
        subject.radix_mask.should == 3333333333
      end

      it "returns the mask specified by specific bit location" do
        subject.default = {'radix' => 3}
        yaml = YAML.load <<-YAML
        radix:
          2: [3,4,5]
        YAML
        subject.radix = yaml['radix']
        subject.radix_mask.should == 3333222333
      end

      it "raises an error if radix is not defined" do
        subject.radix = nil
        expect { subject.radix_mask }.to raise_error(ArgumentError) 
      end
    end
  end
end
