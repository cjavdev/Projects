require 'rspec'
require_relative '../red_black_tree.rb'

describe RBTree do
  subject { RBTree.new }
  let(:n1) { RBNode.new(1) }
  let(:n3) { RBNode.new(3) }
  let(:n4) { RBNode.new(4) }
  let(:n7) { RBNode.new(7) }
  let(:n8) { RBNode.new(8) }
  let(:n9) { RBNode.new(9) }
  let(:n10) { RBNode.new(10) }
  let(:n11) { RBNode.new(11) }
  let(:n12) { RBNode.new(12) }


  describe "#insert" do
    it "insertes a single element and is the black root" do
      subject.insert(n1)
      subject.root.should == n1
      subject.root.color.should == :black
    end

    it "insertes a red child onto a black node" do
      subject.insert(n1)
      subject.insert(n7)
      subject.root.should == n1
      subject.root.color.should == :black
      subject.root.right.should == n7
      subject.root.right.color.should == :red
    end

    it "inserts red child onto inside of red parent nil uncle and adjusts" do
      subject.insert(n1)
      subject.insert(n7)
      subject.insert(n3)
      subject.root.should == n3
      subject.root.color.should == :black
      subject.root.left.value.should == 1
      subject.root.right.value.should == 7
      subject.root.left.color.should == :red
      subject.root.right.color.should == :red
    end

    it "insert red child onto outside of red parent nil uncle and adjusts" do
      subject.insert(n1)
      subject.insert(n7)
      subject.insert(n8)
      subject.root.should == n7
      subject.root.color.should == :black
      subject.root.left.value.should == 1
      subject.root.right.value.should == 8
      subject.root.left.color.should == :red
      subject.root.right.color.should == :red
    end

    it "insert red child to red parent on opposite side of red uncle" do
      subject.insert(n3)
      subject.insert(n1)
      subject.insert(n7)
      subject.root.should == n3
      subject.root.color.should == :black
      subject.root.left.should == n1
      subject.root.right.should == n7

      subject.insert(n8)
      subject.root.should == n3
      subject.root.right.color.should == :black
      subject.root.left.color.should == :black
      subject.root.right.right.color.should == :red
      subject.root.right.right.value.should == 8
    end

    it "insert red child to red parent on same side of red uncle" do
      subject.insert(n3)
      subject.insert(n1)
      subject.insert(n7)
      subject.insert(n4)
      subject.root.should == n3
      subject.root.right.color.should == :black
      subject.root.right.value.should == 7
      subject.root.right.left.color.should == :red
      subject.root.right.left.value.should == 4
      subject.root.left.color.should == :black
      subject.root.left.value.should == 1
    end

    it "insert red child to red parent with black uncle and adjusts" do
      subject.insert(n3)
      subject.insert(n1)
      subject.insert(n7)
      subject.insert(n8)
      subject.insert(n9)

      subject.root.should == n3
      subject.root.left.color.should == :black
      subject.root.left.value.should == 1
      subject.root.right.should == n8
      subject.root.right.color.should == :black
      subject.root.right.left.should == n7
      subject.root.right.left.color.should == :red
      subject.root.right.right.should == n9
      subject.root.right.right.color.should == :red
    end

    it "insert red child to red parent with red uncle on outside of uncle" do
      subject.insert(n3)
      subject.insert(n1)
      subject.insert(n7)
      subject.insert(n8)
      subject.insert(n9)
      subject.insert(n10)

      subject.root.should == n3
      subject.root.right.color.should == :red
      subject.root.right.value.should == 8
      subject.root.left.color.should == :black
      subject.root.left.value.should == 1
      subject.root.right.left.should == n7
      subject.root.right.right.should == n9
      subject.root.right.right.right.should == n10
      subject.root.right.right.right.color.should == :red
    end

    it "insert a red child at the bottom of a tree and rotates about root" do
      subject.insert(n3)
      subject.insert(n1)
      subject.insert(n7)
      subject.insert(n8)
      subject.insert(n9)
      subject.insert(n10)
      subject.insert(n11)
      subject.insert(n12)

      #check left sub tree
      subject.root.should == n8
      subject.root.color.should == :black
      subject.root.left.should == n3
      subject.root.left.color.should == :red
      subject.root.left.left.should == n1
      subject.root.left.right.should == n7
      subject.root.left.left.color.should == :black
      subject.root.left.right.color.should == :black

      #check right sub tree
      subject.root.right.should == n10
      subject.root.right.color.should == :red
      subject.root.right.left.should == n9
      subject.root.right.left.color.should == :black
      subject.root.right.right.should == n11
      subject.root.right.right.color.should == :black
      subject.root.right.right.right.should == n12
      subject.root.right.right.right.color.should == :red
    end

    it "spot check for left side of the tree adding" do
      subject.insert(n12)
      subject.insert(n11)
      subject.insert(n10)
      subject.insert(n9)
      subject.insert(n8)
      subject.insert(n7)
      subject.insert(n3)
      subject.insert(n1)

      #this is mostly a sanity check
      subject.root.left.left.left.should == n1
      subject.root.should == n9
      subject.root.right.right.should == n12
    end

    it "returns the correct height" do
      subject.insert(n1)
      subject.insert(n3)
      subject.insert(n8)
      subject.height.should == 2
    end

    it "returns the correct width" do
      subject.insert(n1)
      subject.insert(n3)
      subject.insert(n8)
      subject.width.should == 2
    end
  end
end
