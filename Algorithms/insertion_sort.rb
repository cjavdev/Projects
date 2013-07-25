def insertion_sort array
  i = 0
  while i < array.length - 1
    j = i + 1
    while j > 0
      if array[j-1] > array[j]
        array[j-1], array[j] = array[j], array[j-1]
        j -= 1
      else
        break
      end
    end
    i += 1
  end
  array
end

p insertion_sort [3,2,1,5,2]
