require 'rspec'
require 'linked_list'

describe LinkedList do
  subject { LinkedList.new }
  let(:n1) { Link.new(1) }
  let(:n2) { Link.new(2) }

  describe "#insert" do
    it "inserts an item into the LinkedList" do
      subject.insert n1
      subject.length.should == 1
    end

    it "inserts multiple items into the LinkedList" do
      subject.insert n1
      subject.insert n2
      subject.length.should == 2
    end
  end
end
