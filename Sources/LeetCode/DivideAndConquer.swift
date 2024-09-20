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
