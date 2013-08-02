require 'debugger'

class HeapNode
  attr_accessor :value, :left, :right, :parent
  include Comparable
  
  def initialize value
    @value = value
  end
  
  def <=>(other)
    @value  <=> other.value  
  end
end

class Heap
  attr_accessor :root, :compare_proc
  
  def initialize &compare_proc
    @root = nil
    @compare_proc = compare_proc
  end
  
  def insert node
    if @root.nil?
      @root = node
      return
    end
      
    f = @root
    f = f.left || f.right until f.left.nil? || f.right.nil?
    if f.left
      f.right = node
    else
      f.left = node
    end
    node.parent = f
    
    heap_up node
  end
  
  def heap_up node
    sorted = false
    until sorted
      sorted = true
      if node.parent && @compare_proc.call(node, node.parent) == 1
        node.value, node.parent.value = node.parent.value, node.value
        node = node.parent
        sorted = false
      elsif node.parent.nil?
        @root = node
      end
    end
    
    if (@root.left  && @compare_proc.call(@root.left, @root) == 1) || 
       (@root.right && @compare_proc.call(@root.right, @root) == 1)
      heap_up @root
    end
  end
  
  def heap_down node
    sorted = false
    until sorted
      sorted = true
      if node.left &&  @compare_proc.call(node.left, node) == 1
        node.left.value, node.value = node.value, node.left.value
        node = node.left
        sorted = false
      elsif node.right &&  @compare_proc.call(node.right, node) == 1
        node.right.value, node.value = node.value, node.right.value
        node = node.right
        sorted = false
      end
    end
    
    if (@root.left  && @compare_proc.call(@root.left, @root) == 1) || 
       (@root.right && @compare_proc.call(@root.right, @root) == 1)
      heap_down @root
    end
  end

  def remove
    result = @root.dup
    
    f = @root
    f = f.left || f.right until f.left.nil? && f.right.nil?
    @root.value, f.value = f.value, @root.value
    if f.parent && f.parent.left == f
      f.parent.left = nil
    elsif f.parent && f.parent.right == f
      f.parent.right = nil
    else
      if @root.left.nil? && @root.right.nil? && f == @root
        @root = nil 
      end
      f = nil
    end
    
    heap_down @root if @root
    result
  end
end

class MaxHeap < Heap
  def initialize
    super { |x, y| x <=> y }
  end
end

class MinHeap < Heap
  def initialize
    super { |x, y| y <=> x }
  end
end
