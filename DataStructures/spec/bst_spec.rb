require 'rspec'
require_relative '../bst.rb'

describe "Red Black Tree" do
  subject { RBBinarySearchTree.new }
  let(:n1) { RedBlackNode.new(1) }
  let(:n3) { RedBlackNode.new(3) }
  let(:n7) { RedBlackNode.new(7) }
  let(:n8) { RedBlackNode.new(8) }
  let(:n9) { RedBlackNode.new(9) }
  let(:n10) { RedBlackNode.new(10) }

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

    it "pushes red child onto inside of red parent and adjusts" do
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

    it "pushes red child onto outside of red parent and adjusts" do
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
  end
end
