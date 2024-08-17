/// Binary tree right side view
///
/// Given the `root` of a binary tree, imagine yourself standing on the **right
/// side** of it, return _the values of the nodes you can see ordered from top
/// to bottom_.
func rightSideView(_ root: TreeNode?) -> [Int] {
	var view = [Int]()

	var currentLevel = [TreeNode]()
	if let root {
		currentLevel.append(root)
	}

	while !currentLevel.isEmpty {
		view.append(currentLevel.last!.val)

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

	return view
}

/// Average of levels in binary tree
///
/// Given the `root` of a binary tree, return _the average value of the nodes on
/// each level in the form of an array_. Answers within `10^(-5)` of the actual
/// answer will be accepted.
func averageOfLevels(_ root: TreeNode?) -> [Double] {
	var averages = [Double]()

	var currentLevel = [TreeNode]()
	if let root {
		currentLevel.append(root)
		averages.append(.init(root.val))
	}

	while !currentLevel.isEmpty {
		var nextLevel = [TreeNode]()
		var sum = 0, count = 0

		for node in currentLevel {
			if let left = node.left {
				nextLevel.append(left)
				sum += left.val
				count += 1
			}
			if let right = node.right {
				nextLevel.append(right)
				sum += right.val
				count += 1
			}
		}

		if count > 0 {
			averages.append(.init(sum) / .init(count))
		}
		currentLevel = nextLevel
	}

	return averages
}

/// Binary tree level order traversal
///
/// Given the `root` of a binary tree, return _the level order traversal of its
/// nodes' values_. (i.e., from left to right, level by level).
func levelOrder(_ root: TreeNode?) -> [[Int]] {
	var levels = [[Int]]()

	var currentLevel = [TreeNode]()
	if let root {
		currentLevel.append(root)
	}

	while !currentLevel.isEmpty {
		var nextLevel = [TreeNode]()
		var values = [Int]()

		for node in currentLevel {
			values.append(node.val)
			if let left = node.left {
				nextLevel.append(left)
			}
			if let right = node.right {
				nextLevel.append(right)
			}
		}

		levels.append(values)
		currentLevel = nextLevel
	}

	return levels
}

/// Binary tree zigzag level order traversal
///
/// Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).
func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
	[]
}
