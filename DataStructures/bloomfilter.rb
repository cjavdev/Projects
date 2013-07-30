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
    @vector = @vector | new
  end

  def includes? string
    new = Bitwise.new
    new.raw = Digest::SHA2.hexdigest(string)
    new.bits == (new & @vector).bits
  end
end
