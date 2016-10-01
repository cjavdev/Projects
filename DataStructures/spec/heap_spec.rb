require 'rspec'
require 'heap'

describe Heap do
  subject { Heap.new {|x,y| x<=>y } }
  let(:n1) { HeapNode.new(1) }
  let(:n2) { HeapNode.new(2) }
  let(:n3) { HeapNode.new(3) }
  let(:n4) { HeapNode.new(4) }
  let(:n5) { HeapNode.new(5) }
  let(:n6) { HeapNode.new(6) }

  describe "#insert" do
    it "can insert a single item" do
      subject.insert n1
      subject.root.should == n1
    end

    it "can insert multiple items correctly" do
      subject.insert n1
      subject.insert n2
      subject.root.value.should == 2

      subject.insert n6
      subject.insert n4
      subject.insert n5
      subject.insert n3
      subject.root.value.should == 6
    end
  end

  describe "#remove" do
    it "can properly remove the biggest item" do
      subject.insert n1
      subject.insert n2
      subject.remove.value.should == 2
      subject.remove.value.should == 1
      subject.insert n3
      subject.insert n6
      subject.insert n5
      subject.insert n4
      subject.remove.value.should == 6
      subject.remove.value.should == 5
      subject.remove.value.should == 4
      subject.remove.value.should == 3
    end
  end
end

describe MaxHeap do
  subject { MaxHeap.new }
  let(:n1) { HeapNode.new(1) }
  let(:n2) { HeapNode.new(2) }
  let(:n3) { HeapNode.new(3) }
  let(:n4) { HeapNode.new(4) }
  let(:n5) { HeapNode.new(5) }
  let(:n6) { HeapNode.new(6) }

  describe "#insert" do
    it "can insert a single item" do
      subject.insert n1
      subject.root.should == n1
    end

    it "can insert multiple items correctly" do
      subject.insert n1
      subject.insert n2
      subject.root.value.should == 2

      subject.insert n6
      subject.insert n4
      subject.insert n5
      subject.insert n3
      subject.root.value.should == 6
    end
  end

  describe "#remove" do
    it "can properly remove the biggest item" do
      subject.insert n1
      subject.insert n2
      subject.remove.value.should == 2
      subject.remove.value.should == 1
      subject.insert n3
      subject.insert n6
      subject.insert n5
      subject.insert n4
      subject.remove.value.should == 6
      subject.remove.value.should == 5
      subject.remove.value.should == 4
    end
  end
end

describe MinHeap do
  subject { MinHeap.new }
  let(:n1) { HeapNode.new(1) }
  let(:n2) { HeapNode.new(2) }
  let(:n3) { HeapNode.new(3) }
  let(:n4) { HeapNode.new(4) }
  let(:n5) { HeapNode.new(5) }
  let(:n6) { HeapNode.new(6) }

  describe "#insert" do
    it "can insert multiple items correctly" do
      subject.insert n1
      subject.insert n2
      subject.root.value.should == 1

      subject.insert n6
      subject.insert n4
      subject.insert n5
      subject.insert n3
      subject.root.value.should == 1
      subject.insert HeapNode.new(0)
      subject.root.value.should == 0
    end
  end

  describe "#remove" do
    it "can properly remove the smallest item" do
      subject.insert n1
      subject.insert n2
      subject.remove.value.should == 1
      subject.remove.value.should == 2
      subject.insert n3
      subject.insert n6
      subject.insert n5
      subject.insert n4
      subject.remove.value.should == 3
      subject.remove.value.should == 4
    end
  end
end
