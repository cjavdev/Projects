def merge_sort array
  return array if array.length == 1
  middle = array.length / 2
  left = array[0...middle]
  right = array[middle...array.length]
  merge( merge_sort(left), merge_sort(right) )
end

def merge a1, a2
  final = []
  until a1.empty? || a2.empty?
    final << ((a1[0] < a2[0]) ? a1.shift : a2.shift)
  end
  final + a1 + a2
end

p merge_sort [4,2,5,65,2,5,4,2,4]
