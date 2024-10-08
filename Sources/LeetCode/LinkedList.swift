struct LinkedList: CustomDebugStringConvertible, Equatable {
	var head: ListNode?
	var tail: ListNode?
	var count = 0

	init(_ elements: [Int]) {
		for e in elements {
			let node = ListNode(e)
			if head != nil, let tail {
				tail.next = node
				self.tail = node
			} else {
				head = node
				tail = node
			}
			count += 1
		}
	}

	init(_ head: ListNode?) {
		if let head {
			self.head = head
			count = 1
		}

		tail = head
		while let next = tail?.next {
			count += 1
			tail = next
		}
	}

	subscript(_ index: Int) -> ListNode? {
		if index < 0 || index >= count {
			return nil
		}
		var node = head
		for _ in 0..<index {
			node = node?.next
		}
		return node
	}

	var debugDescription: String {
		var s = ""
		var current = head
		for i in 0..<count {
			s += "\(current!.val)"
			if i < count - 1 {
				s += ", "
			}
			current = current?.next
		}
		return s
	}

	static func ==(lhs: LinkedList, rhs: LinkedList) -> Bool {
		guard lhs.count == rhs.count else {
			return false
		}

		let s1 = sequence(first: lhs.head, next: \.?.next)
		let s2 = sequence(first: rhs.head, next: \.?.next)

		for (n1, n2) in zip(s1, s2) {
			guard let v1 = n1?.val, let v2 = n2?.val, v1 == v2 else {
				return n1 == nil && n2 == nil
			}
		}

		return true
	}
}

class ListNode: CustomDebugStringConvertible {
	var val: Int
	var next: ListNode?
	var random: ListNode?

	init() {
		self.val = 0
		self.next = nil
	}

	init(_ val: Int) {
		self.val = val
		self.next = nil
	}

	init(_ val: Int, _ next: ListNode?) {
		self.val = val
		self.next = next
	}

	var debugDescription: String {
		if let next {
			"\(val) -> \(next.debugDescription)"
		} else {
			"\(val)"
		}
	}
}

fileprivate typealias Node = ListNode

/// Linked list cycle
///
/// Given `head`, the head of a linked list, determine if the linked list has a
/// cycle in it.
///
/// There is a cycle in a linked list if there is some node in the list that can
/// be reached again by continuously following the `next` pointer. Internally,
/// `pos` is used to denote the index of the node that tail's `next` pointer is
/// connected to. **Note that `pos` is not passed as a parameter**.
///
/// Return _`true` if there is a cycle in the linked list. Otherwise, return
/// `false`_.
func hasCycle(_ head: ListNode?) -> Bool {
	var fast = head?.next
	var slow = head

	while fast != nil, slow != nil {
		if fast === slow {
			return true
		}
		fast = fast?.next?.next
		slow = slow?.next
	}

	return false
}

/// Add two numbers
///
/// You are given two **non-empty** linked lists representing two non-negative
/// integers. The digits are stored in **reverse order**, and each of their
/// nodes contains a single digit. Add the two numbers and return the sum as a
/// linked list.
///
/// You may assume the two numbers do not contain any leading zero, except the
/// number 0 itself.
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
	let nodes = sequence(first: (l1, l2)) { n1, n2 in
		if n1?.next == nil && n2?.next == nil {
			nil
		} else {
			(n1?.next, n2?.next)
		}
	}

	var result: ListNode?
	var tail: ListNode?
	var carry = false

	for node in nodes {
		let (n1, n2) = node
		let digit = (n1?.val ?? 0) + (n2?.val ?? 0) + (carry ? 1 : 0)
		let node = ListNode(digit % 10)
		carry = digit >= 10
		if result == nil {
			result = node
		}
		tail?.next = node
		tail = node
	}

	if carry {
		tail?.next = ListNode(1)
	}

	return result
}

/// Merge two sorted lists
///
/// You are given the heads of two sorted linked lists `list1` and `list2`.
///
/// Merge the two lists into one `sorted` list. The list should be made by
/// splicing together the nodes of the first two lists.
///
/// Return _the head of the merged linked list_.
func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
	var head: ListNode?, tail: ListNode?
	var l1 = list1, l2 = list2

	while l1 != nil || l2 != nil {
		let node: ListNode?

		if l2 == nil || l1 != nil && l1!.val <= l2!.val {
			node = l1
			l1 = l1?.next
		} else {
			node = l2
			l2 = l2?.next
		}

		if head == nil {
			head = node
		}

		tail?.next = node
		tail = node
	}

	return head
}

/// Copy list with random pointer
///
/// A linked list of length `n` is given such that each node contains an
/// additional random pointer, which could point to any node in the list, or
/// `null`.
///
/// Construct a **deep copy** of the list.
/// The deep copy should consist of exactly `n` brand new nodes, where each new
/// node has its value set to the value of its corresponding original node.
/// Both the `next` and `random` pointer of the new nodes should point to new
/// nodes in the copied list such that the pointers in the original list and
/// copied list represent the same list state.
/// **None of the pointers in the new list should point to nodes in the original
/// list**.
///
/// For example, if there are two nodes `X` and `Y` in the original list, where
/// `X.random --> Y`, then for the corresponding two nodes `x` and `y` in the
/// copied list, `x.random --> y`.
///
/// Return _the head of the copied linked list_.
///
/// The linked list is represented in the input/output as a list of `n` nodes.
/// Each node is represented as a pair of `[val, random_index]` where:
///
/// - `val`: an integer representing `Node.val`
/// - `random_index`: the index of the node (range from `0` to `n - 1`) that the
///   `random` pointer points to, or `null` if it does not point to any node.
///
/// Your code will **only** be given the `head` of the original linked list.
func copyRandomList(_ head: ListNode?) -> ListNode? {
	var next = head
	while let current = next {
		let copy = Node(current.val)
		next = current.next
		copy.next = current.next
		current.next = copy
	}

	next = head
	while let current = next, let copy = current.next {
		if let random = current.random {
			copy.random = random.next
		}
		next = copy.next
	}

	var copyOfHead: Node?

	next = head
	while let current = next, let copy = current.next {
		if copyOfHead == nil {
			copyOfHead = copy
		}
		next = copy.next
		current.next = next
		copy.next = next?.next
	}

	return copyOfHead
}

/// Reverse linked list II
///
/// Given the head of a singly linked list and two integers `left` and `right`
/// where `left <= right`, reverse the nodes of the list from position `left` to
/// position `right`, and return _the reversed list_.
func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
	let dummy = ListNode(0, head)

	var i = 0
	var previous: ListNode?
	var current: ListNode? = dummy
	var next = current?.next

	var nodeBeforeLeft: ListNode?

	while i <= right, current != nil {
		if i == left, nodeBeforeLeft == nil {
			nodeBeforeLeft = previous
		} else if i > left {
			current?.next = previous
		}

		i += 1
		previous = current
		current = next
		next = next?.next
	}

	nodeBeforeLeft?.next?.next = current
	nodeBeforeLeft?.next = previous

	return dummy.next
}

/// Reverse nodes in k-group
///
/// Given the `head` of a linked list, reverse the nodes of the list `k` at a
/// time, and return _the modified list_.
///
/// `k` is a positive integer and is less than or equal to the length of the
/// linked list. If the number of nodes is not a multiple of `k` then left-out
/// nodes, in the end, should remain as it is.
///
/// You may not alter the values in the list's nodes, only nodes themselves may
/// be changed.
func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
	/// The dummy node that appears before the head of the list.
	let dummy = ListNode(0, head)
	/// The node before the start of the k-group.
	var before: _? = dummy

	// while there might be a group
	while before != nil {
		/// Index of the current node.
		var i = 0
		/// Current node.
		var current = before?.next

		// find the node after the group, starting from the node after `before`
		while i < k, current != nil {
			i += 1
			current = current?.next
		}

		// break if the number of nodes in this group is less than k
		if i < k {
			break
		}

		// otherwise, there are k nodes in this group, and `current` points to
		// the node after the last node in the group

		/// The node after the end of the k-group.
		let after = current

		/// The node before the current node.
		var previous = before

		// move current back to the start of the group
		current = before?.next

		// reverse the group
		while current !== after {
			let next = current?.next
			current?.next = previous
			previous = current
			current = next
		}

		before?.next?.next = after
		let nextBefore = before?.next
		before?.next = previous
		before = nextBefore
	}

	return dummy.next
}

/// Remove nth node from end of list
///
/// Given the `head` of a linked list, remove the `nth` node from the end of the
/// list and return its head.
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
	let dummy = ListNode(0, head)
	var tail = head, beforeTarget: _? = dummy
	var distance = 1

	while distance < n {
		tail = tail?.next
		distance += 1
	}

	while tail?.next != nil {
		beforeTarget = beforeTarget?.next
		tail = tail?.next
	}

	beforeTarget?.next = beforeTarget?.next?.next

	return dummy.next
}

/// Remove duplicates from sorted list II
///
/// Given the `head` of a sorted linked list, _delete all nodes that have
/// duplicate numbers, leaving only distinct numbers from the original list_.
/// Return _the linked list **sorted** as well_.
func deleteDuplicates(_ head: ListNode?) -> ListNode? {
	let dummy = ListNode((head?.val ?? 0) - 1, head)
	var left: _? = dummy, right = dummy.next

	while right != nil {
		if right?.val == right?.next?.val {
			while right?.val == right?.next?.val {
				right = right?.next
			}
			left?.next = right?.next
		} else {
			left = left?.next
		}

		right = right?.next
	}

	return dummy.next
}

/// Rotate list
///
/// Given the `head` of a linked list, rotate the list to the right by `k`
/// places.
func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
	let dummy = ListNode(0, head)
	var tail: _? = dummy
	var n = 0

	while let t = tail?.next {
		n += 1
		tail = t
	}

	guard n > 0, k % n > 0 else {
		return head
	}

	let indexOfNewTail = n - k % n - 1
	var beforeNewHead: _? = head
	var i = 0

	while i < indexOfNewTail {
		i += 1
		beforeNewHead = beforeNewHead?.next
	}

	let newHead = beforeNewHead?.next
	beforeNewHead?.next = nil
	tail?.next = head

	return newHead
}

/// Partition list
///
/// Given the `head` of a linked list and a value `x`, partition it such that
/// all nodes **less than** `x` come before nodes **greater than or equal** to
/// `x`.
///
/// You should **preserve** the original relative order of the nodes in each of
/// the two partitions.
func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
	let dummy = ListNode(x - 1, head)
	var left: _? = dummy

	while (left?.next?.val ?? x) < x {
		left = left?.next
	}

	var right = left

	while let next = right?.next {
		if next.val < x {
			right?.next = next.next
			next.next = left?.next
			left?.next = next
			left = next
		} else {
			right = right?.next
		}
	}

	return dummy.next
}

/// LRU cache
///
/// Design a data structure that follows the constraints of a **Least Recently
/// Used (LRU) cache**.
///
/// Implement the `LRUCache` class:
///
/// - `LRUCache(int capacity)` Initialize the LRU cache with **positive** size
///   `capacity`.
/// - `int get(int key)` Return the value of the `key` if the key exists,
///   otherwise return `-1`.
/// - `void put(int key, int value)` Update the value of the `key` if the `key`
///   exists. Otherwise, add the `key-value` pair to the cache. If the number of
///   keys exceeds the `capacity` from this operation, **evict** the least
///   recently used key.
///
/// The functions `get` and `put` must each run in `O(1)` average time
/// complexity.
class LRUCache {
	private class Node {
		let key: Int
		var value: Int
		var previous: Node?
		var next: Node?

		init(_ key: Int = 0, _ val: Int = 0) {
			self.key = key
			self.value = val
		}
	}

	private let capacity: Int
	private let queue: Node
	private var cache: [Int: Node] = [:]

	init(_ capacity: Int) {
		self.capacity = capacity
		queue = Node()
	}

	func get(_ key: Int) -> Int {
		guard let node = cache[key] else {
			return -1
		}
		moveToEndOfQueue(node: node)
		return node.value
	}

	func put(_ key: Int, _ value: Int) {
		if cache[key] == nil, cache.count + 1 > capacity, let node = queue.next {
			cache.removeValue(forKey: node.key)
			queue.next = queue.next?.next
			queue.next?.previous = queue
		}

		let node = cache[key] ?? Node(key)
		node.value = value
		cache[key] = node

		moveToEndOfQueue(node: node)

		if cache.count == 1 {
			queue.next = node
			node.previous = queue
		}
	}

	private func moveToEndOfQueue(node: Node) {
		node.previous?.next = node.next
		node.next?.previous = node.previous
		
		queue.previous?.next = node
		node.previous = queue.previous
		
		queue.previous = node
		node.next = queue
	}
}
