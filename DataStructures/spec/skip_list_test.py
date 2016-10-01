import unittest
import random

from lib.skip_list import SortedLinkedList
from lib.skip_list import SkipList


class SortedLinkedListTest(unittest.TestCase):

    def test_delete_last(self):
        list = SortedLinkedList()
        list.insert(1)
        list.insert(2)
        list.insert(3)
        list.delete(1)
        self.assertEqual(list.head.data, 2)
        self.assertEqual(list.head.next.data, 3)

    def test_delete_head(self):
        list = SortedLinkedList()
        list.insert(1)
        list.insert(2)
        list.insert(3)
        list.delete(3)
        self.assertEqual(list.head.data, 1)
        self.assertEqual(list.head.next.data, 2)

    def test_delete_middle(self):
        list = SortedLinkedList()
        list.insert(1)
        list.insert(2)
        list.insert(3)
        list.delete(2)
        self.assertEqual(list.head.data, 1)
        self.assertEqual(list.head.next.data, 3)

    def test_insert_smaller(self):
        list = SortedLinkedList()
        list.insert(2)
        self.assertEqual(list.head.data, 2)
        list.insert(1)
        self.assertEqual(list.head.data, 1)
        list.insert(3)
        self.assertEqual(list.head.next.next.data, 3)

    def test_insert_one_item(self):
        list = SortedLinkedList()
        list.insert(1)
        self.assertEqual(list.head.data, 1)

    def test_insert_larger(self):
        list = SortedLinkedList()
        list.insert(1)
        list.insert(2)
        self.assertEqual(list.head.next.data, 2)

    def test_print(self):
        list = SortedLinkedList()
        list.insert(1)
        list.insert(2)
        list.insert(3)
        self.assertEqual(str(list), '1 - 2 - 3')


class SkipListTest(unittest.TestCase):

    def test_seeded_flip_test(self):
        l = SkipList()
        random.seed(1)
        self.assertTrue(l.should_promote())
        self.assertFalse(l.should_promote())
        self.assertFalse(l.should_promote())
        self.assertTrue(l.should_promote())
        self.assertTrue(l.should_promote())
        self.assertTrue(l.should_promote())
        self.assertFalse(l.should_promote())
        self.assertFalse(l.should_promote())
        self.assertTrue(l.should_promote())

    def test_insert_one_item(self):
        l = SkipList()
        random.seed(1)
        l.insert(1)
        self.assertEqual(l.lists[0].head.data, float('-inf'))
        self.assertEqual(l.lists[0].head.next.data, 1)
        self.assertEqual(2, len(l.lists))
        self.assertEqual(l.lists[1].head.next.data, 1)
        self.assertEqual(l.lists[1].head.down, l.lists[0].head)
        self.assertEqual(l.lists[1].head.next.down, l.lists[0].head.next)

    def test_insert_two_items(self):
        l = SkipList()
        random.seed(1)
        l.insert(1)
        l.insert(2)
        self.assertEqual(l.lists[0].head.data, float('-inf'))
        self.assertEqual(l.lists[0].head.next.data, 1)
        self.assertEqual(l.lists[0].head.next.next.data, 2)
        self.assertEqual(l.lists[1].head.next.next, None)

    def test_insert_many_items(self):
        l = SkipList()
        random.seed(1)
        l.insert(1) # Promoted
        l.insert(2)
        l.insert(3) # Promoted
        self.assertEqual(l.lists[0].head.data, float('-inf'))
        self.assertEqual(l.lists[0].head.next.data, 1)
        self.assertEqual(l.lists[0].head.next.next.data, 2)
        self.assertEqual(l.lists[0].head.next.next.next.data, 3)
        self.assertEqual(l.lists[1].head.next.data, 1)
        self.assertEqual(l.lists[1].head.next.down, l.lists[0].head.next)
        self.assertEqual(l.lists[1].head.next.next.data, 3)
        self.assertEqual(
            l.lists[1].head.next.next.down, l.lists[0].head.next.next.next)
        self.assertEqual(len(l.lists), 4)

    def test_find_one_item(self):
        l = SkipList()
        random.seed(1)
        l.insert(1)
        self.assertEqual(l.find(1), l.lists[0].head.next)
        self.assertEqual(1, l.lists[0].head.next.data)

    def test_find_missing_item(self):
        l = SkipList()
        random.seed(1)
        l.insert(1)
        self.assertEqual(l.find(2), None)

    def test_find_with_two_items(self):
        l = SkipList()
        random.seed(1)
        l.insert(1)
        l.insert(2)
        self.assertEqual(l.find(2), l.lists[0].head.next.next)
        self.assertEqual(2, l.lists[0].head.next.next.data)

    def test_find_item(self):
        l = SkipList()
        random.seed(1)
        l.insert(1)
        l.insert(2)
        l.insert(3)
        l.insert(5)
        l.insert(9)
        l.insert(7)
        l.display()
        self.assertEqual(l.find(7), l.lists[0].head.next.next.next.next.next)
        self.assertEqual(7, l.lists[0].head.next.next.next.next.next.data)
