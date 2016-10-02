import unittest

from merge_sort import merge
from merge_sort import merge_sort


class MergeTest(unittest.TestCase):

    def test_merges_to_items(self):
        self.assertEqual([1, 2], merge([1], [2]))

class MergeSortTest(unittest.TestCase):

    def test_sorts_no_items(self):
        self.assertEqual([], merge_sort([]))

    def tests_sorts_one_item(self):
        self.assertEqual([1], merge_sort([1]))

    def tests_sorts_two_items(self):
        self.assertEqual([1, 2], merge_sort([2, 1]))

    def tests_sorts_many_items(self):
        self.assertEqual(
            [1, 1, 2, 2, 3, 3, 4], merge_sort([2, 1, 3, 4, 2, 1, 3]))
