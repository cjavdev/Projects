def quick3_sort (array, left = 0, right = array.length-1)
  if left < right
    l_pivot_idx = (left + right) / 3 # this should be random
    r_pivot_idx = 2 * ((left + right) / 3) # this should also be random

    puts "left pivot idx #{ l_pivot_idx }"
    puts "right pivot idx #{ r_pivot_idx }"

    if r_pivot_idx < array.length && array[l_pivot_idx] > array[r_pivot_idx]
      array[l_pivot_idx], array[r_pivot_idx] = array[r_pivot_idx], array[l_pivot_idx]
    end

    l_pivot_idx, r_pivot_idx = partition( array, left, right, l_pivot_idx, r_pivot_idx )
    
    quick3_sort(array, left, l_pivot_idx -1)
    quick3_sort(array, l_pivot_idx + 1, r_pivot_idx -1)
    quick3_sort(array, r_pivot_idx + 1, right)
  end
  array
end

def partition( array, left, right, l_pivot_idx, r_pivot_idx )
  l_front_ptr = left
  r_front_ptr = (left + right) / 2

  l_pivot_val = array[l_pivot_idx]
  r_pivot_val = array[r_pivot_idx]

  array[l_pivot_idx], array[right] = array[right], array[l_pivot_idx]
  array[r_pivot_idx], array[right - 1] = array[right - 1], array[r_pivot_idx]

  (left...right - 1).to_a.each do |idx|
    if array[idx] < l_pivot_val
      array[l_front_ptr], array[idx] = array[idx], array[l_front_ptr]
      l_front_ptr += 1
    elsif array[idx] < r_pivot_val
      array[r_front_ptr], array[idx] = array[idx], array[r_front_ptr]
      r_front_ptr += 1
    end
  end
  
  array[l_front_ptr], array[right] = array[right], array[l_front_ptr]
  array[r_front_ptr], array[right - 1] = array[right - 1], array[r_front_ptr]
  [l_front_ptr, r_front_ptr]
end

p quick3_sort([3,2,1,5,2,4,65,23,465,1])
