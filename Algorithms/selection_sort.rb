def selection_sort array
  new_array = []
  front = 0
  until front == array.length
    j = front
    min = array[front]
    min_idx = front


    until j == array.length - 1
      if array[j + 1] < min
        min = array[j + 1]
        min_idx = j + 1
      end

      j += 1
    end
    p array
    puts "swapping #{array[front]} #{front} and #{array[min_idx]} #{min_idx}"
    array[front], array[min_idx] = array[min_idx], array[front]
    front += 1
  end
  array
end

p selection_sort [3,2,1,4,5,4,34,33,3, -1, 100, 100, -1]
