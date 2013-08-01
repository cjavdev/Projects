class Node
  attr_accessor :value, :left, :right, :parent

  def initialize value
    @value = value
  end
  
  def <=>(other)
    other.value <=> @value  
  end
end

class Heap
  attr_accessor :max, :count
  def initialize
    @nodes = []
    @root = nil
  end
  
  def insert node
    
  end

  def remove
    
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
