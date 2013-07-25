# Prisoner is like a 'Link'
class Prisoner
  attr_accessor :value, :nxt, :prev
  # the head of the list will pass nil prev and nil nxt
  # when initializing the chain with an array the prev
  # will come in handy.
  def initialize value, prev = nil, nxt = nil
    @value = value
    @nxt = nxt
    @prev = prev
  end
end

class PrisonerChain
  attr_accessor :head
  # initialize the chain with an array
  def initialize suckers = []
    unless suckers.empty?
      @head = Prisoner.new(suckers.first)
      prev = @head
      suckers[1..-1].each do |prisoner|
        node = Prisoner.new(prisoner, prev)
        prev.nxt = node
        prev = node
      end
      @head
    end
  end

  # execute every nth prisoner until only one remains
  def execute nth
    simon = @head
    until simon.nxt.nil? && simon == @head
      nth.times do 
        simon = simon.nxt || @head
      end
      kill simon
    end
    puts "#{ simon.value } survived"
  end

  def kill prisoner
    if prisoner.prev
      prev = prisoner.prev
      prev.nxt = prisoner.nxt
      prev.nxt.prev = prev
    else
      @head = prisoner.nxt
    end
  end

  def to_s
    ptr = @head
    result = "["
    until ptr.nxt.nil?
      result += "#{ ptr.value } "
      ptr = ptr.nxt
    end
    result.strip + "]"
  end
end

list = PrisonerChain.new((1..5).to_a)
p list
