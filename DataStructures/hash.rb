require 'digest/sha1'

class MyHash
  attr_reader :buckets
  include Enumerable

  def initialize
    @buckets =  [nil] * 10
    @count = 1
  end

  def [] key
    index = (hash key) % @buckets.length
    @buckets[ index ].each { |kv| return kv[1] if kv[0] == key }
    nil
  end

  def []= key, value
    @count += 1
    double_buckets if @buckets.length < @count
    index = (hash key) % @buckets.length
    @buckets[ index ] = [] if @buckets[ index ].nil?
    remove key if self[key]
    @buckets[ index ] << [ key, value ]
  end

  def double_buckets
    temp = [nil] * (@buckets.length * 2)
    @buckets.each do |bucket|
      unless bucket.nil?
        bucket.each do |kv|
          index = (hash kv[0]) % temp.length
          temp[index] = [] if temp[index].nil?
          temp[index] << kv
        end
      end
    end
    @buckets = temp
  end

  def each &blk
    @buckets.each do |bucket|
      unless bucket.nil?
        bucket.each { |kv| blk.call(kv[0], kv[1]) }
      end
    end
  end

  def each_key &blk
    @buckets.each do |bucket|
      bucket.each { |kv| blk.call(kv[0]) } unless bucket.nil?
    end
  end

  def each_value &blk
    @buckets.each do |bucket|
      bucket.each { |kv| blk.call(kv[1]) } unless bucket.nil?
    end
  end

  def remove key
   index = (hash key) % @buckets.length
   @count -= 1
   @buckets[ index ].reject! { |kv| kv[0] == key }
  end

  private
  def hash key
    Digest::SHA1.hexdigest(key).hex
  end
end
