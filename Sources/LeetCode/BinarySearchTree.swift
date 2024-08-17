/// Minimum absolute difference in BST
///
/// Given the `root` of a Binary Search Tree (BST), return _the minimum absolute
/// difference between the values of any two different nodes in the tree_.
func getMinimumDifference(_ root: TreeNode?) -> Int {
	var minDiff = Int.max

	var path = [TreeNode]()
	var node = root
	var previous: Int?

	while node != nil || !path.isEmpty {
		while let current = node {
			path.append(current)
			node = current.left
		}

		let next = path.popLast()
		if let previous, let next, next.val - previous < minDiff {
			minDiff = next.val - previous
		}
		previous = next?.val
		node = next?.right
	}

	return minDiff
}

/// Kth smallest element in a BST
///
/// Given the `root` of a binary search tree, and an integer `k`, return _the
/// `kth` smallest value (**1-indexed**) of all the values of the nodes in the
/// tree_.
func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
	var index = 0

	func explore(_ node: TreeNode?) -> TreeNode? {
		guard let node else {
			return nil
		}

		if let left = explore(node.left) {
			return left
		}

		index += 1
		if index == k {
			return node
		}

		return explore(node.right)
	}

	return explore(root)?.val ?? .max
}

/// Validate binary search tree
///
/// Given the `root` of a binary tree, _determine if it is a valid binary search
/// tree (BST)_.
///
/// A valid BST is defined as follows:
///
/// - The left subtree of a node contains only nodes with keys **less than** the
///   node's key.
/// - The right subtree of a node contains only nodes with keys **greater than**
///   the node's key.
/// - Both the left and right subtrees must also be binary search trees.
func isValidBST(_ root: TreeNode?) -> Bool {
	func isValidBST(_ node: TreeNode?, _ min: Int, _ max: Int) -> Bool {
		guard let node else {
			return true
		}
		return node.val > min && node.val < max && isValidBST(
			node.left, min, node.val
		) && isValidBST(
			node.right, node.val, max
		)
	}

	return isValidBST(root, .min, .max)
}
