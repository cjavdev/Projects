class MyDeque
  attr_reader :front, :back
  def initialize
    @front = nil
    @back = nil
  end

  def shift
    node = @back
    @back = @back.next
  end

  def unshift(node)
    @back.prev = node
    node.next = @back
    @back = node
  end

  def pop
    node = @front
    @front = @front.prev
  end

  def push(node)
    @front.next = node
    node.prev = @front
    @front = node
  end
end

class Node
  attr_accessor :next, :prev
  attr_reader :data
  def initialize(data)
    @next = nil
    @prev = nil
  end
end
