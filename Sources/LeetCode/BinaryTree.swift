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
