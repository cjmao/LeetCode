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
	nil
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
	nil
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
