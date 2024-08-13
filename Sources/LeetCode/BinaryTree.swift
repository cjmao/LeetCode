class TreeNode: CustomDebugStringConvertible {
	var val: Int
	var left: TreeNode?
	var right: TreeNode?
	var size: Int

	init(
		_ val: Int = 0,
		_ left: TreeNode? = nil,
		_ right: TreeNode? = nil
	) {
		self.val = val
		self.left = left
		self.right = right
		self.size = 1 + (left?.size ?? 0) + (right?.size ?? 0)
	}

	init?(_ array: [Int?]) {
		guard !array.isEmpty else {
			return nil
		}

		var nodes = [TreeNode?]()
		for n in array {
			nodes.append(n == nil ? nil : .init(n!))
		}

		self.val = nodes[0]!.val
		self.size = 1

		for i in nodes[1...].indices {
			if let node = nodes[i] {
				let parent = nodes[(i - 1) / 2]!
				if i % 2 == 1 {
					parent.left = node
				} else {
					parent.right = node
				}
				self.size += 1
			}
		}

		self.left = nodes[0]!.left
		self.right = nodes[0]!.right
	}

	var debugDescription: String {
		let left = (self.left?.debugDescription ?? "nil")
			.split(separator: "\n")
		let right = (self.right?.debugDescription ?? "nil")
			.split(separator: "\n")

		return (["\(val)"] + left + right).joined(separator: "\n\t")
	}
}

/// Maximum depth of binary tree
///
/// Given the `root` of a binary tree, return _its maximum depth_.
///
/// A binary tree's **maximum depth** is the number of nodes along the longest
/// path from the root node down to the farthest leaf node.
func maxDepth(_ root: TreeNode?) -> Int {
	guard let root else {
		return 0
	}

	var levels = 0
	var currentLevel = [root]

	while !currentLevel.isEmpty {
		levels += 1
		var nextLevel = [TreeNode]()

		for node in currentLevel {
			if let left = node.left {
				nextLevel.append(left)
			}
			if let right = node.right {
				nextLevel.append(right)
			}
		}

		currentLevel = nextLevel
	}

	return levels
}

/// Same tree
///
/// Given the roots of two binary trees `p` and `q`, write a function to check
/// if they are the same or not.
///
/// Two binary trees are considered the same if they are structurally identical,
/// and the nodes have the same value.
func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
	guard let p, let q else {
		return p == nil && q == nil
	}

	var currentLevel = [(p, q)]

	while !currentLevel.isEmpty {
		var nextLevel = [(TreeNode, TreeNode)]()

		for (p, q) in currentLevel {
			if p.val != q.val {
				return false
			}
			if let pLeft = p.left, let qLeft = q.left {
				nextLevel.append((pLeft, qLeft))
			} else if !(p.left == nil && q.left == nil) {
				return false
			}
			if let pRight = p.right, let qRight = q.right {
				nextLevel.append((pRight, qRight))
			} else if !(p.right == nil && q.right == nil) {
				return false
			}
		}

		currentLevel = nextLevel
	}

	return true
}

/// Invert binary tree
///
/// Given the `root` of a binary tree, invert the tree, and return _its root_.
func invertTree(_ root: TreeNode?) -> TreeNode? {
	guard let root else {
		return nil
	}

	var currentLevel = [root]

	while !currentLevel.isEmpty {
		var nextLevel = [TreeNode]()

		for node in currentLevel {
			let left = node.left
			let right = node.right

			node.left = right
			node.right = left

			if let left {
				nextLevel.append(left)
			}
			if let right {
				nextLevel.append(right)
			}
		}

		currentLevel = nextLevel
	}

	return root
}

/// Symmetric tree
///
/// Given the `root` of a binary tree, check _whether it is a mirror of itself_
/// (i.e., symmetric around its center).
func isSymmetric(_ root: TreeNode?) -> Bool {
	func isSymmetric(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
		if let left, let right, left.val == right.val {
			isSymmetric(left.left, right.right)
			&& isSymmetric(left.right, right.left)
		} else {
			left == nil && right == nil
		}
	}

	return isSymmetric(root?.left, root?.right)
}

/// Construct binary tree from preorder and inorder traversal
///
/// Given two integer arrays `preorder` and `inorder` where `preorder` is the
/// preorder traversal of a binary tree and `inorder` is the inorder traversal
/// of the same tree, construct and return _the binary tree_.
func buildTreeFromPreorderAndInorder(
	_ preorder: [Int],
	_ inorder: [Int]
) -> TreeNode? {
	let inorderIndicies: [Int: Int] = inorder.enumerated()
		.reduce(into: [:]) { result, ix in
			let (i, x) = ix
			result[x] = i
		}

	func buildSubtree(
		_ preorderRoot: Int, _ startIndex: Int, _ endIndex: Int
	) -> TreeNode? {
		let rootValue = preorder[preorderRoot]
		let inorderRoot = inorderIndicies[rootValue]!
		let root = TreeNode(rootValue)

		if startIndex < inorderRoot {
			root.left = buildSubtree(
				preorderRoot + 1,
				startIndex,
				inorderRoot
			)
		}
		if inorderRoot + 1 < endIndex {
			root.right = buildSubtree(
				preorderRoot + 1 + inorderRoot - startIndex,
				inorderRoot + 1,
				endIndex
			)
		}

		return root
	}

	return buildSubtree(
		preorder.startIndex,
		inorder.startIndex,
		inorder.endIndex
	)
}

/// Construct binary tree from inorder and postorder traversal
///
/// Given two integer arrays `inorder` and `postorder` where `inorder` is the
/// inorder traversal of a binary tree and `postorder` is the postorder
/// traversal of the same tree, construct and return _the binary tree_.
func buildTreeFromInorderAndPostorder(
	_ inorder: [Int],
	_ postorder: [Int]
) -> TreeNode? {
	let inorderIndicies: [Int: Int] = inorder.enumerated()
		.reduce(into: [:]) { result, ix in
			let (i, x) = ix
			result[x] = i
		}

	func buildSubtree(
		_ postorderRoot: Int, _ firstIndex: Int, _ lastIndex: Int
	) -> TreeNode? {
		let rootValue = postorder[postorderRoot]
		let inorderRoot = inorderIndicies[rootValue]!
		let root = TreeNode(rootValue)

		if lastIndex > inorderRoot {
			root.right = buildSubtree(
				postorderRoot - 1,
				inorderRoot + 1,
				lastIndex
			)
		}
		if inorderRoot > firstIndex {
			root.left = buildSubtree(
				postorderRoot - 1 - lastIndex + inorderRoot,
				firstIndex,
				inorderRoot - 1
			)
		}

		return root
	}

	return buildSubtree(
		postorder.endIndex - 1,
		inorder.startIndex,
		inorder.endIndex - 1
	)
}
