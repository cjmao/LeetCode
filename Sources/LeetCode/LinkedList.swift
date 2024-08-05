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

public class ListNode {
	public var val: Int
	public var next: ListNode?
	public init(_ val: Int) {
		self.val = val
		self.next = nil
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
