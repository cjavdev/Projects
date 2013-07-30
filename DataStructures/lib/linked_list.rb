require 'debugger'

class Link
  attr_accessor :prev, :next, :value

  def initialize value
    @value = value
  end

  def == other
    @value == other || (other.is_a?(Link) && @value = other.value)
  end
end

class LinkedList
  attr_accessor :head, :butt

  def push node
    if @head.nil?
      @head = node
      @butt = node
    else
      temp_last = @butt
      @butt.next = node
      @butt = node
      node.prev = temp_last
    end
  end
  
  # both parent and child must be links
  def insert_after parent, child
    raise "Not a Link" unless parent.is_a?(Link) && child.is_a?(Link)
    @ptr = @head
    @ptr = @ptr.next until @ptr == parent || @ptr.nil?

    raise "Um... I didn't find that parent. :(" if @ptr.nil?
    
    child.next = @ptr.next
    @ptr.next = child
    child.prev = @ptr
    @ptr
  end

  # node can either be a value or an actual node
  def delete node
    @ptr = @head
    @ptr = @ptr.next until @ptr == node || @ptr.nil?

    @ptr.next.prev = @ptr.prev || nil if @ptr.next
    @ptr.prev.next = @ptr.next || nil if @ptr.prev
    @head = @ptr.next if @head == node
    @butt = @ptr.prev if @butt == node
  end

  def to_s
    @ptr = @head
    result = "["
    until @ptr.nil?
      result += "#{ @ptr.value } "
      @ptr = @ptr.next
    end
    result + "]"
  end
end

list = LinkedList.new
l = Link.new(1)
list.push(l)
list.push(Link.new(2))
list.push(Link.new(3))
list.delete(2)
puts list
list.insert_after(l, Link.new(4))
puts list

class Josephus
  attr_accessor :prisoners, :survivors
  def initialize num_prisoners
    

  end

  def execute
    
  end
end


