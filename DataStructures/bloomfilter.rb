require 'bitwise'
require 'digest'

class Bloomfilter
  attr_reader :vector

  def initialize
    @vector = Bitwise.new
  end

  def add string
    
  end

  def includes? string
    
  end
end
