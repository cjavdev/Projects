require 'rspec'
require_relative '../bst.rb'

describe RBBinarySearchTree do
  subject { RBBinarySearchTree.new }
  let(:n1) { RedBlackNode.new(1) }
  let(:n3) { RedBlackNode.new(3) }
  let(:n4) { RedBlackNode.new(4) }
  let(:n7) { RedBlackNode.new(7) }
  let(:n8) { RedBlackNode.new(8) }
  let(:n9) { RedBlackNode.new(9) }
  let(:n10) { RedBlackNode.new(10) }
  let(:n11) { RedBlackNode.new(11) }
  let(:n12) { RedBlackNode.new(12) }


  describe "#push" do
    it "pushes a single element and is the black root" do
      subject.push(n1)
      subject.root.should == n1
      subject.root.color.should == :black
    end

    it "pushes a red child onto a black node" do
      subject.push(n1)
      subject.push(n7)
      subject.root.should == n1
      subject.root.color.should == :black
      subject.root.right.should == n7
      subject.root.right.color.should == :red
    end

    it "pushes red child onto inside of red parent nil uncle and adjusts" do
      subject.push(n1)
      subject.push(n7)
      subject.push(n3)
      subject.root.should == n3
      subject.root.color.should == :black
      subject.root.left.value.should == 1
      subject.root.right.value.should == 7
      subject.root.left.color.should == :red
      subject.root.right.color.should == :red
    end

    it "pushes red child onto outside of red parent nil uncle and adjusts" do
      subject.push(n1)
      subject.push(n7)
      subject.push(n8)
      subject.root.should == n7
      subject.root.color.should == :black
      subject.root.left.value.should == 1
      subject.root.right.value.should == 8
      subject.root.left.color.should == :red
      subject.root.right.color.should == :red
    end

    it "pushes red child to red parent on opposite side of red uncle" do
      subject.push(n3)
      subject.push(n1)
      subject.push(n7)
      subject.root.should == n3
      subject.root.color.should == :black
      subject.root.left.should == n1
      subject.root.right.should == n7

      subject.push(n8)
      subject.root.should == n3
      subject.root.right.color.should == :black
      subject.root.left.color.should == :black
      subject.root.right.right.color.should == :red
      subject.root.right.right.value.should == 8
    end

    it "pushes red child to red parent on same side of red uncle" do
      subject.push(n3)
      subject.push(n1)
      subject.push(n7)
      subject.push(n4)
      subject.root.should == n3
      subject.root.right.color.should == :black
      subject.root.right.value.should == 7
      subject.root.right.left.color.should == :red
      subject.root.right.left.value.should == 4
      subject.root.left.color.should == :black
      subject.root.left.value.should == 1
    end

    it "pushes red child to red parent with black uncle and adjusts" do
      subject.push(n3)
      subject.push(n1)
      subject.push(n7)
      subject.push(n8)
      subject.push(n9)

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

    it "pushes red child to red parent with red uncle on outside of uncle" do
      subject.push(n3)
      subject.push(n1)
      subject.push(n7)
      subject.push(n8)
      subject.push(n9)
      subject.push(n10)

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

    it "pushes a red child at the bottom of a tree and rotates about root" do
      subject.push(n3)
      subject.push(n1)
      subject.push(n7)
      subject.push(n8)
      subject.push(n9)
      subject.push(n10)
      subject.push(n11)
      subject.push(n12)

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
      subject.push(n12)
      subject.push(n11)
      subject.push(n10)
      subject.push(n9)
      subject.push(n8)
      subject.push(n7)
      subject.push(n3)
      subject.push(n1)

      #this is mostly a sanity check
      subject.root.left.left.left.should == n1
      subject.root.should == n9
      subject.root.right.right.should == n12
    end
  end
end
