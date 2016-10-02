def quick_sort(array, left=0, right=array.length-1)
  if left < right
    pivot_idx = (left + right) / 2
    puts left
    puts right
    pivot_idx = partition(array, left, right, pivot_idx)

    quick_sort(array, left, pivot_idx - 1)
    quick_sort(array, pivot_idx + 1, right)
  end
  array
end

def partition(array, left, right, pivot_idx )
  front_ptr = left
  pivot_val = array[pivot_idx]

  array[pivot_idx], array[right] = array[right], array[pivot_idx]

  (left...right).to_a.each do |idx|
    if array[idx] < pivot_val
      array[front_ptr], array[idx] = array[idx], array[front_ptr]
      front_ptr += 1
    end
  end
  array[front_ptr], array[right] = array[right], array[front_ptr]
  front_ptr
end

p quick_sort([3,2,1,5,2,4,65,23,465,1])
