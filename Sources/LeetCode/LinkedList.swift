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

	static func ==(l1: Self, l2: Self) -> Bool {
		guard l1.count == l2.count else {
			return false
		}

		var n1 = l1.head
		var n2 = l2.head

		while n1 != nil {
			if n1?.val != n2?.val {
				return false
			}
			n1 = n1?.next
			n2 = n2?.next
		}

		return true
	}
}

public class ListNode: CustomDebugStringConvertible {
	public var val: Int
	public var next: ListNode?

	public init() {
		self.val = 0
		self.next = nil
	}

	public init(_ val: Int) {
		self.val = val
		self.next = nil
	}

	public init(_ val: Int, _ next: ListNode?) {
		self.val = val
		self.next = next
	}

	public var debugDescription: String {
		"\(val) -> \(next?.debugDescription ?? "nil")"
	}
}

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
	nil
}
