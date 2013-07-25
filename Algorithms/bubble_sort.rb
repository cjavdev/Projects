def bubble_sort array
  sorted = false
  until sorted
    sorted = true
    (0...array.length-1).to_a.each do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        sorted = false
      end
    end
  end
  array
end

p bubble_sort [1,3,4,2,34,8,43,43,3,34]
