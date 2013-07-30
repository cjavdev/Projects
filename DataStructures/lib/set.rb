class MySet
  attr_reader :internal_hash

  def initialize(array)
    @internal_hash = {}
    array.each do |elem|
      @internal_hash[elem] = true
    end
    self
  end

  def union(another_set)
    MySet.new(another_set.internal_hash.keys + @internal_hash.keys)
  end

  def intersect(another_set)
    result = []
    @internal_hash.keys.each do |key|
      result << key if another_set[key]
    end
    MySet.new(result)
  end

  def [](key)
    @internal_hash[key]
  end

  def difference(another_set)
    result = []
    @internal_hash.keys.each do |key|
      result << key unless another_set[key]
    end
    MySet.new(result)
  end

  def subset?(smaller_set)
    dup_smaller_set = smaller_set.dup
    @internal_hash.keys.each do |key|
      dup_smaller_set.remove(key)
    end
    dup_smaller_set.count == 0
  end

  def dup
    MySet.new(@internal_hash.keys.dup)
  end

  def count
    @internal_hash.select{|k, v| v}.keys.count
  end

  def add(element)
    @internal_hash[element] = true
  end

  def remove(element)
    @internal_hash[element] = false
  end

  def to_s
    @internal_hash.select{|k, v| v}.keys.inspect
  end
end

s = MySet.new([1, 2, 3, 4])
t = MySet.new([3, 4, 5, 6])

puts "union of s and t: #{ s.union(t) }"
puts "intersection of s and t: #{ s.intersect(t) }"
puts "difference s and t: #{ s.difference(t) }"
puts "subset? of s and t: #{ s.subset?(t) }"
puts "subset? of s and v: #{ s.subset?(MySet.new([1,2])) } "
s.add(7)
puts "after adding to s: #{ s }"
s.remove(1)
puts "after removing from s: #{ s }"
