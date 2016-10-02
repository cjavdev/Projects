import random


count = 0
def partition(array, lo, hi):
    global count
    i = lo - 1
    mid = int(random.uniform(lo, hi))
    array[mid], array[hi] = array[hi], array[mid]
    pivot = array[hi]

    for j in xrange(lo, hi):
        count += 1
        if array[j] <= pivot:
            i += 1
            array[i], array[j] = array[j], array[i]
    i += 1
    array[i], array[hi] = array[hi], array[i]
    return i


def quick_sort(array, lo=0, hi=None):
    if hi is None:
        hi = len(array) - 1
    if lo < hi:
        p = partition(array, lo, hi)
        quick_sort(array, lo, p - 1)
        quick_sort(array, p + 1, hi)

counts = []
for f in xrange(1000):
    arr = [1, 2, 3, 3, 2, 1, 6, 100, 3, 5, 4, 5, 4]
    quick_sort(arr)
    counts.append(count)
    count = 0

def mean(numbers):
    return float(sum(numbers)) / max(len(numbers), 1)

print len(counts)
print mean(counts)
