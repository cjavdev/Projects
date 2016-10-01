
def heapify array
  puts "heapifying array: #{array.inspect}"

  start = (array.length - 2) / 2
  while start >= 0
    sink(array, start, array.length - 1)
    start -= 1
    p array
  end
  puts "done heapifying array:"
  p array
end

def sink array, start, finish
  puts "sinking array: #{array.inspect}"
  root = start
  puts "root is #{root}"

  while root * 2 + 1 <= finish
    left = root * 2 + 1
    right = left + 1

    swap = root
    swap = left if array[swap] < array[left]

    if right <= finish && array[swap] < array[right]
      swap = right
    end

    unless swap == root
      array[swap], array[root] = array[root], array[swap]
      root = swap
    else
      puts "done sinking"
      p array
      return
    end
  end
end

def heap_sort array
  puts "Heapsorting:"

  heapify array
  finish = array.length - 1

  while finish > 0
    array[finish], array[0] = array[0], array[finish]
    finish -= 1
    sink(array, 0, finish)
  end

  array
end

p heap_sort [3,5,2,1]
