require 'bitwise'
require 'digest'

class Bloomfilter
  attr_reader :vector

  def initialize
    @vector = Bitwise.new
  end

  def add(string)
    new = Bitwise.new
    new.raw = Digest::SHA2.hexdigest(string)
    @vector |= new
  end

  def includes? string
    
  end
end

b = Bloomfilter.new
p b.add("test")
p b.add("smash")

p b.includes?("test")
p b.includes?("another")

