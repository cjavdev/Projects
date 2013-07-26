require 'colored'
require 'singleton'
require 'debugger'

class TreeNode
  attr_accessor :left, :right, :parent, :value
  include Comparable

  def initialize value
    @value = value
  end

  def <=>(other)
    @value <=> other.value
  end

  def grandparent
    return @parent.parent if @parent
    nil
  end

  def uncle
    return grandparent.right if !!grandparent && grandparent.left == @parent
    return grandparent.left  if !!grandparent && grandparent.right == @parent
    nil
  end

  def each &blk
    left.each &blk unless left.nil?
    blk.call(self)
    right.each &blk unless right.nil?
  end
end

class RBNode < TreeNode
  attr_accessor :color

  def initialize value, parent = nil, color = :red
    super value
    @parent = parent
    @color = color
    if value
      @left = RBNode.new nil, self, :black
      @right = RBNode.new nil, self, :black
    end
  end

  def to_s
    if @value
      "*#{ @value }: #{ @color == :black ? 'black' : 'red  ' } p: #{ !!@parent ? @parent.value : nil } l: #{ !!@left ? @left.value : nil } r: #{ !!@right ? @right.value : nil }*\n" 
    else
      ""
    end
  end
end

class RBTree
  attr_accessor :root
  include Enumerable

  def << val
    insert RBNode.new(val)
  end

  def insert node
    if @root.nil?
      @root = node
    else
      @root = @root.parent until @root.parent.nil?
      finder = @root
      until finder.value.nil?
        finder = node > finder ? finder.right : finder.left
      end

      finder.value, finder.color = node.value, :red
      finder.left = RBNode.new(nil, finder, :black) 
      finder.right = RBNode.new(nil, finder, :black)
    end
    finder ||= node
    push_case_1 finder
  end

  # case 1: node is root
  def push_case_1 node
    if node.parent.nil?
      node.color = :black
    else
      push_case_2 node
    end
  end

  # case 2: black parent
  def push_case_2 node
    return if node.parent.color == :black
    push_case_3 node
  end

  # case 3: red parent AND red uncle
  def push_case_3 node
    if node.parent.color == :red && node.uncle.color == :red
      node.parent.color      = :black
      node.uncle.color       = :black
      node.grandparent.color = :red

      #continue swapping colors up the tree
      push_case_1 node.grandparent
      return
    end
    push_case_4 node
  end

  # case 4: red parent AND black uncle
  # and the node is on the same side of the parent as the uncle
  def push_case_4 node
    if node.parent.color == :red && node.uncle.color == :black
      # is right child?
      if node == node.parent.right && node.grandparent.left == node.parent
        rotate_left(node, node.parent)
        push_case_5 node.left
      elsif node == node.parent.left && node.grandparent.right == node.parent
        rotate_right(node, node.parent)
        push_case_5 node.right
      else
        push_case_5 node # can i fix these?
      end
    else
      push_case_5 node # ?
    end
  end

  # case 5: red parent AND black uncle
  # and the node is on the opposite side of the parent as the uncle
  def push_case_5 node
    node.parent.color = :black
    node.grandparent.color = :red if node.grandparent

    if node == node.parent.left && node.grandparent.left == node.parent
      rotate_right(node.parent, node.grandparent)
    elsif node == node.parent.right && node.grandparent.right == node.parent
      rotate_left(node.parent, node.grandparent)
    end
  end

  #   X          Y
  #  / \   =>   / \
  # a   Y      X   c
  #    / \    / \
  #   b   c  a   b
  def rotate_left node, parent
    parent.right = node.left
    node.left = parent
    node.parent = node.grandparent
    parent.parent = node

    if node.parent
      node.parent.left = node if node.parent.left == parent
      node.parent.right = node if node.parent.right == parent
    end
    @root = node if @root == parent
  end

  #     X        Y
  #    / \ =>   / \
  #   Y   c    a   X
  #  / \          / \
  # a   b        b   c
  def rotate_right node, parent
    parent.left = node.right
    node.right = parent
    node.parent = node.grandparent
    parent.parent = node

    if node.parent
      node.parent.left = node if node.parent.left == parent
      node.parent.right = node if node.parent.right == parent
    end
    @root = node if @root == parent
  end

  def each &blk
    @root.each(&blk)
  end

  def p_in_order
    @root.p_in_order
  end
end


tree = RBTree.new
tree << 1
tree << 2
tree << 3
tree << 4

tree.each do |node|
  puts node
end




