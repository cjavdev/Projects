require 'colored'
require 'debugger'

class Node
  attr_accessor :left, :right, :parent, :value

  def initialize value
    @value = value
  end

  def >(other)
    return false if @value.nil? || other.nil? || other.value.nil?
    @value > other.value
  end

  def ==(other)
    @value == other.value
  end

  def <(other)
    return false if @value.nil? || other.nil? || other.value.nil?
    @value < other.value
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

  def p_in_order
    left.p_in_order unless left.nil?
    print "#{ self }"
    right.p_in_order unless right.nil?
  end

  def pre_order
    print "#{ self } "
    left.pre_order unless left.nil?
    right.pre_order unless right.nil?
  end
end

class RedBlackNode < Node
  attr_accessor :color

  def initialize value, parent = nil, color = :red
    super value
    @parent = parent
    @color = color
    if value
      @left = RedBlackNode.new(nil, self, :black) # sentinal
      @right = RedBlackNode.new(nil, self, :black) # sentinal
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

class RBBinarySearchTree
  attr_accessor :root

  def push node
    puts "pushing node: #{ node.value }"
    if @root.nil?
      @root = node
    else
      @root = @root.parent until @root.parent.nil?
      finder = @root
      until finder.value.nil?
        if node > finder
          finder = finder.right
        else
          finder = finder.left
        end
      end

      finder.value = node.value
      finder.left = RedBlackNode.new(nil, finder, :black)
      finder.right = RedBlackNode.new(nil, finder, :black)
      finder.color = :red
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
    if node.parent.color == :red && !!node.uncle && node.uncle.color == :red
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
    if node.parent.color == :red && !!node.uncle && node.uncle.color == :black
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
    grandparent = node.parent

    if grandparent
      grandparent.left = node if grandparent.left == parent
      grandparent.right = node if grandparent.right == parent
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
    grandparent = node.parent

    if grandparent
      grandparent.left = node if grandparent.left == parent
      grandparent.right = node if grandparent.right == parent
    end
    @root = node if @root == parent
  end

  def p_in_order
    @root.p_in_order
  end
end

