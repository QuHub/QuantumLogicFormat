require 'spec_helper'

describe Base::Specification do
  let(:filename){File.expand_path('../../fixtures/ternary.qlf', __FILE__)}
  let(:configuration) {Base::Configuration.new(filename)}
  subject {Base::Specification.new(configuration)}

  describe "#raw" do
    it "returns raw specification as read in yaml file" do
      subject.raw.should == "021 022\n022 021\n121 122\n122 121\n210 220\n211 221\n212 222\n220 210\n221 211\n222 212\n"
    end
  end

  describe '#parsed' do
    it 'should do nothing if the wildcard pattern not found' do
      subject.stub(:raw => "22 33\n44 55")
      subject.parsed.size.should == 2
      subject.parsed.first.should == [22, 44]
      subject.parsed.last.should == [33, 55]
    end
  end

  describe '.generate' do
    context "reflection" do
      it 'should generate specification for 2 variables' do
        expected = load_fixture('reflection_3_2.qlf')
        described_class.generate('reflection', 3, 2).should eql(expected)
      end

      it 'should generate specification for 3 variables' do
        expected = load_fixture('reflection_3_3.qlf')
        described_class.generate('reflection', 3, 3).should eql(expected)
      end
    end
  end
end
