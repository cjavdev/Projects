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


class BinaryTree
  attr_accessor :root
  include Enumerable

  def << val
    insert TreeNode.new(val)
  end

  def insert node
    if @root.nil?
      @root = node
    else
      finder = @root
      until finder.left.nil? || finder.right.nil?
        finder = finder.left || finder.right
      end
      # fill the tree from top to bottom left to right
      if finder.left.nil?
        finder.left = node
      else
        finder.right = node
      end
    end
  end

  def each &blk
    @root.each &blk
  end
end

