import random


class Node:
    """
    Node is similar to a normal Node in a Singly Linked List, however this one
    also has an added `down` property to help with SkipList.
    """

    def __init__(self, data, next=None, down=None):
        self.data = data
        self.next = next
        self.down = down


class SortedLinkedList:
    """
    A linked list that maintains sorted order.
    """

    def __init__(self, head=None):
        self.head = head

    def __str__(self):
        items = []
        current = self.head
        while current:
            items.append(str(current.data))
            current = current.next
        return ' - '.join(items)

    def insert_node(self, node):
        # Case 1: add before head
        if self.head is None or node.data < self.head.data:
            node.next = self.head
            self.head = node
            return

        # Case 2: insert later
        current = self.head
        next = current.next
        while next is not None and next.data < node.data:
            current = next
            next = next.next
        node.next = next
        current.next = node

    def insert(self, data):
        # Case 1: add before head
        if self.head is None or data < self.head.data:
            node = Node(data, self.head)
            self.head = node
            return

        # Case 2: insert later
        current = self.head
        next = current.next
        while next is not None and next.data < data:
            current = next
            next = next.next
        node = Node(data, next)
        current.next = node

    def delete(self, data):
        # Case 1: delete the head
        if self.head.data == data:
            self.head = self.head.next

        # Case 2: delete in the middle or end
        current = self.head
        next = current.next
        while next is not None:
            if next.data == data:
                current.next = next.next
            current = next
            next = next.next


class SkipList:
    """
    Will find items in log N time most of the time with high probability
    because... math.
    """

    def __init__(self):
        base = SortedLinkedList()
        base.insert(float('-inf'))
        self.lists = [base]

    def add_layer(self):
        base = SortedLinkedList()
        base.insert(float('-inf'))
        base.head.down = self.lists[-1].head
        self.lists.append(base)

    def display(self):
        for i in xrange(len(self.lists)):
            print self.lists[len(self.lists) - i - 1]

    def should_promote(self):
        return random.random() < .5

    def find(self, data):
        # Starting with the last list (a.k.a L1, the level with the fewest
        # nodes)
        list = self.lists[-1]

        # Setup our runners
        current = list.head
        next = current.next

        # While we're still in an "express" level (fewer than N nodes)
        while current.down:

            # At end of this level, go down.
            if next is None:
                current = current.down
                next = current.next

            # The next node has our target value.
            if next and next.data == data:
                # Drop down to the bottom level and return the base node,
                # This could probably just return "next", but just incase the
                # bottom level node is special for some reason and hasn't copied
                # all of the data, lets return that one.
                while next.down:
                    next = next.down
                return next

            # Haven't found our target, nor reached the end of the level so
            # Let's Walk right
            if next and next.data < data:
                current = next
                next = next.next
                continue

            # Next is larger than target, go down.
            if next and next.data > data:
                current = current.down
                next = current.next

    def insert(self, data):
        """
        Note: This is naiive and should use the same algorithm as find ^.
        This is worse than just inserting into a single sorted list. :(
        """
        node = Node(data)
        self.lists[0].insert_node(node)
        i = 0
        down = node
        while self.should_promote():
            i += 1
            if len(self.lists) <= i:
                self.add_layer()
            parent_node = Node(data, down=down)
            down = parent_node
            self.lists[i].insert_node(parent_node)
