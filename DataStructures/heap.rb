class HeapNode
  attr_accessor :value, :left, :right, :parent

  def initialize value
    @value = value
  end
  
  def >(other)
    @value > other.value
  end
  
  def ==(other)
    @value == other.value
  end
end

class Heap
  attr_accessor :max, :count
  
  # takes an array of values
  def initialize vals
    @nodes = []
    vals.each { |val| self.push HeapNode.new(val) }
    @count = vals.length
    heapify
  end

  def pop
    heapify
  end

  def push node
    b = @max
    until b.right.nil? || b.left.nil?
      b = b.right || b.left
    end
    
    unless b.left
      b.left = node
      node.parent = b
    else
      b.right = node
      node.parent = b
    end

    @count += 1
    heapify
  end
 
  def swap(big, small)
    if small.parent.nil? #smaller was root
      if small.left == big
        small.left = big.left
        small.right = big.right
        big.left = small
        big.right = nil
      elsif small.right == big
         
      end
    else
      if small.parent.left == small
        small.parent.left = big
      elsif small.parent.right == small
        small.parent.right = big
      end
    end
  end

  def heapify
    @finder = @max
    temp_nodes = @nodes.dup
    until temp_nodes.empty
      current = temp_nodes.pop
      if current > current.parent
        swap(current, current.parent)
      end
    end
  end
end
