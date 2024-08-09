struct LinkedList: CustomDebugStringConvertible {
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
	nil
}
