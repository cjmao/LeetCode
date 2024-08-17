import Testing
@testable import LeetCode

@Suite("Binary Search Tree")
struct BinarySearchTreeTests {
	@Test("Minimum absolute difference in BST", arguments: [
		TestCase(given: [4, 2, 6, 1, 3], expected: 1),
		TestCase(given: [1, 0, 48, nil, nil, 12, 49], expected: 1),
		TestCase(given: [1, nil, 3, nil, nil, 2], expected: 1),
		TestCase(given: [236, 104, 701, nil, 227, nil, 911], expected: 9),
	])
	func testGetMinimumDifference(c: TestCase<[Int?], Int>) throws {
		let (root, expected) = (c.given, c.expected)

		let nodes = root.compactMap(\.self)
		try #require(nodes.count >= 2)
		try #require(nodes.allSatisfy { $0 >= 0 })

		let tree = TreeNode(root)
		#expect(getMinimumDifference(tree) == expected)
	}

	@Test("Kth smallest element in a BST", arguments: [
		TestCase(given: Pair([3, 1, 4, nil, 2], 1), expected: 1),
		TestCase(given: Pair([5, 3, 6, 2, 4, nil, nil, 1], 3), expected: 3),
	])
	func testKthSmallest(c: TestCase<Pair<[Int?], Int>, Int>) throws {
		let ((root, k), expected) = (c.given.values, c.expected)

		let nodes = root.compactMap(\.self)
		try #require(1 <= k && k <= nodes.count)
		try #require(nodes.allSatisfy { $0 >= 0 })

		let tree = TreeNode(root)
		#expect(kthSmallest(tree, k) == expected)
	}

	@Test("Validate binary search tree", arguments: [
		TestCase(given: [2, 1, 3], expected: true),
		TestCase(given: [5, 1, 4, nil, nil, 3, 6], expected: false),
	])
	func testIsValidBST(c: TestCase<[Int?], Bool>) throws {
		let (root, expected) = (c.given, c.expected)
		try #require(!root.compactMap(\.self).isEmpty)
		let tree = TreeNode(root)
		#expect(isValidBST(tree) == expected)
	}
}
