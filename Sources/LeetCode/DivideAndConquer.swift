/// Convert sorted array to binary search tree
///
/// Given an integer array `nums` where the elements are sorted in **ascending
/// order**, convert _it to a **height-balanced** binary search tree_.
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
	func convert(from start: Int, to end: Int) -> TreeNode? {
		guard start <= end else { return nil }

		let midpoint = (start + end + 1) / 2
		let root = TreeNode(nums[midpoint])

		root.left = convert(from: start, to: midpoint - 1)
		root.right = convert(from: midpoint + 1, to: end)

		return root
	}

	return convert(from: nums.startIndex, to: nums.endIndex - 1)
}

/// Sort list
///
/// Given the `head` of a linked list, return _the list after sorting it in
/// **ascending order**_.
func sortList(_ head: ListNode?) -> ListNode? {
	guard head?.next != nil else {
		return head
	}

	var slow = head, fast = head?.next

	while let next = fast?.next {
		fast = next.next
		slow = slow?.next
	}

	var right = slow?.next
	slow?.next = nil

	let left = sortList(head)
	right = sortList(right)

	return merge(left, right)
}

private func merge(_ left: ListNode?, _ right: ListNode?) -> ListNode? {
	let head = if let left, let right {
		left.val <= right.val ? left : right
	} else {
		left ?? right
	}

	var tail = head

	var left = tail === left ? left?.next : left
	var right = tail === right ? right?.next : right

	while let l = left, let r = right {
		if l.val <= r.val {
			tail?.next = l
			tail = l
			left = l.next
		} else {
			tail?.next = r
			tail = r
			right = r.next
		}
	}

	tail?.next = left ?? right

	return head
}

/// Construct quad tree
///
/// Given a `n * n` matrix `grid` of `0's` and `1's` only. We want to represent
/// `grid` with a Quad-Tree.
///
/// Return _the root of the Quad-Tree representing `grid`_.
///
/// A Quad-Tree is a tree data structure in which each internal node has exactly
/// four children. Besides, each node has two attributes:
///
/// - `val`: True if the node represents a grid of 1's or False if the node
///   represents a grid of 0's. Notice that you can assign the `val` to True or
///   False when `isLeaf` is False, and both are accepted in the answer.
/// - `isLeaf`: True if the node is a leaf node on the tree or False if the node
///   has four children.
///
/// ```java
/// class Node {
/// 	public boolean val;
/// 	public boolean isLeaf;
/// 	public Node topLeft;
/// 	public Node topRight;
/// 	public Node bottomLeft;
/// 	public Node bottomRight;
/// }
/// ```
///
/// We can construct a Quad-Tree from a two-dimensional area using the following
/// steps:
///
/// 1. If the current grid has the same value (i.e all `1's` or all `0's`) set
///    `isLeaf` True and set `val` to the value of the grid and set the four
///    children to Null and stop.
/// 1. If the current grid has different values, set `isLeaf` to False and set
///    `val` to any value and divide the current grid into four sub-grids.
/// 1. Recurse for each of the children with the proper sub-grid.
///
/// If you want to know more about the Quad-Tree, you can refer to the
/// [wiki](https://en.wikipedia.org/wiki/Quadtree).
///
/// **Quad-Tree format**:
///
/// You don't need to read this section for solving the problem. This is only if
/// you want to understand the output format here. The output represents the
/// serialized format of a Quad-Tree using level order traversal, where `null`
/// signifies a path terminator where no node exists below.
///
/// It is very similar to the serialization of the binary tree. The only
/// difference is that the node is represented as a list `[isLeaf, val]`.
///
/// If the value of `isLeaf` or `val` is True we represent it as **1** in the
/// list `[isLeaf, val]` and if the value of `isLeaf` or `val` is False we
/// represent it as **0**.
func construct(_ grid: [[Int]]) -> QuadTreeNode? {
	func isLeaf(_ rows: Range<Int>, _ columns: Range<Int>) -> Bool {
		var previous: Int?
		for row in rows {
			for column in columns {
				let current = grid[row][column]
				if let previous, previous != current {
					return false
				}
				previous = current
			}
		}
		return true
	}

	func construct(_ rows: Range<Int>, _ columns: Range<Int>) -> Node {
		guard !isLeaf(rows, columns) else {
			return .init(grid[rows.lowerBound][columns.lowerBound] == 1, true)
		}

		let node = Node(true, false)

		let mr = (rows.lowerBound + rows.upperBound) / 2
		let mc = (columns.lowerBound + columns.upperBound) / 2
		let (top, bottom) = (rows.lowerBound..<mr, mr..<rows.upperBound)
		let (left, right) = (columns.lowerBound..<mc, mc..<columns.upperBound)

		node.topLeft = construct(top, left)
		node.topRight = construct(top, right)
		node.bottomLeft = construct(bottom, left)
		node.bottomRight = construct(bottom, right)

		return node
	}

	return construct(0..<grid.count, 0..<grid.count)
}

class QuadTreeNode {
	var val: Bool
	var isLeaf: Bool

	var topLeft: QuadTreeNode?
	var topRight: QuadTreeNode?
	var bottomLeft: QuadTreeNode?
	var bottomRight: QuadTreeNode?

	init(_ val: Bool, _ isLeaf: Bool) {
		self.val = val
		self.isLeaf = isLeaf
	}

	func levels() -> some Sequence<[QuadTreeNode]> {
		sequence(first: [self]) { current -> [_]? in
			guard !current.isEmpty else {
				return nil
			}

			var next = [QuadTreeNode]()

			for node in current {
				let children = [
					node.topLeft, node.topRight,
					node.bottomLeft, node.bottomRight
				].compactMap(\.self)
				next.append(contentsOf: children)
			}

			return next
		}
	}
}

private typealias Node = QuadTreeNode

/// Merge k sorted lists
///
/// You are given an array of `k` linked-lists `lists`, each linked-list is
/// sorted in ascending order.
///
/// _Merge all the linked-lists into one sorted linked-list and return it_.
func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
	func merge(_ lists: ArraySlice<ListNode?>) -> ListNode? {
		guard lists.count > 1 else {
			return lists.first ?? nil
		}

		guard lists.count > 2 else {
			let dummy = ListNode()
			var tail = dummy
			var (h1, h2) = (lists[lists.startIndex], lists[lists.endIndex - 1])

			while let a = h1, let b = h2 {
				if a.val <= b.val {
					tail.next = a
					tail = a
					h1 = a.next
				} else {
					tail.next = b
					tail = b
					h2 = b.next
				}
			}

			tail.next = h1 ?? h2

			return dummy.next
		}

		let midpoint = (lists.startIndex + lists.endIndex) / 2
		let l1 = merge(lists[..<midpoint])
		let l2 = merge(lists[midpoint...])

		return merge([l1, l2][...])
	}

	return merge(lists[...])
}
