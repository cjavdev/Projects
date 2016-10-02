import unittest

from quick_sort import quick_sort


class QuickSortTest(unittest.TestCase):

    def test_sorts_no_items(self):
        arr = []
        quick_sort(arr)
        self.assertEqual([], arr)

    def tests_sorts_one_item(self):
        arr = [1]
        quick_sort(arr)
        self.assertEqual([1], arr)

    def tests_sorts_two_items(self):
        arr = [2, 1]
        quick_sort(arr)
        self.assertEqual([1, 2], arr)

    def xtests_sorts_many_items(self):
        arr = [4, 1, 2, 2, 1, 3, 3]
        quick_sort(arr)
        self.assertEqual([1, 1, 2, 2, 3, 3, 4], arr)
