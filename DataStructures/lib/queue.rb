class MyQueue
  attr_reader :front, :back
  def initialize
    @front = nil
    @back = nil
  end

  def enqueue(node)
    if @front.nil?
      @front = node
      @back = node
    else
      @back.next = node
      @back = node
    end
  end

  def dequeue
    raise "nothing to dequeue" if @front.nil?
    node = @front 
    @front = @front.next
  end
end

class Node
  attr_accessor :next
  attr_reader :data
  def initialize(data)
    @data = data
    @next = nil
  end
  
  def to_s
    data.to_s
  end
end

q = MyQueue.new
a = Node.new("a")
b = Node.new("b")
c = Node.new("c")

q.enqueue(a)
q.enqueue(b)
p q.dequeue
q.enqueue(c)
p q.dequeue
