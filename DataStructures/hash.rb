require 'digest/sha1'
require 'debugger'

class MyHash
  attr_accessor :buckets, :item_count

  def initialize
    @buckets =  [nil] * 10
    @item_count = 1
  end

  def []= key, value
    @item_count += 1
    double_buckets if @buckets.length < @item_count
    hashed_key = Digest::SHA1.hexdigest(key).hex
    destination_idx = hashed_key % @buckets.length
    @buckets[ destination_idx ] = [] if @buckets[ destination_idx ].nil?
    remove key if self[key]
    @buckets[ destination_idx ] << [ key, value ]
  end

  def double_buckets
    temp = [nil] * (@buckets.length * 2)
    @buckets.each do |bucket|
      unless bucket.nil?
        bucket.each do |kv|
          hashed_key = Digest::SHA1.hexdigest(kv[0]).hex
          index = hashed_key % temp.length
          temp[index] = [] if temp[index].nil?
          temp[index] << kv
        end
      end
    end
    @buckets = temp
  end

  def [] key
    hashed_key = Digest::SHA1.hexdigest(key).hex
    index = hashed_key % @buckets.length
    @buckets[ index ].each { |kv| return kv[1] if kv[0] == key }
    nil
  end

  def remove key
   hashed_key = Digest::SHA1.hexdigest(key).hex
   index = hashed_key % @buckets.length
   @item_count -= 1
   @buckets[ index ].reject! { |kv| kv[0] == key }
  end
end
