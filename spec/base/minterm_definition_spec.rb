require 'spec_helper'

describe MintermDefinition do
  describe "#radix_mask" do
    context 'a single radix is given' do
      subject {MintermDefinition.new({'radix' => 3, 'variables' => 10}) }

      it "returns a radix mask representing each digit" do
        subject.radix_mask.should == '3333333333'
      end
    end
  end
end
