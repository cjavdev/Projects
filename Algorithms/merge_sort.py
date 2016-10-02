def merge_sort(unsorted):
    if len(unsorted) <= 1:
        return unsorted
    mid = len(unsorted) / 2
    left = unsorted[0:mid]
    right = unsorted[mid:]
    return merge(merge_sort(left), merge_sort(right))

def merge(list_a, list_b):
    result = []
    while list_a and list_b:
        if list_a[0] > list_b[0]:
            result.append(list_b[0])
            list_b = list_b[1:]
        else:
            result.append(list_a[0])
            list_a = list_a[1:]
    return result + list_a + list_b

