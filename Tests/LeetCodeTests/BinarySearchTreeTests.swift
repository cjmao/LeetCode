import Testing
@testable import LeetCode

@Suite("Binary Search Tree")
struct BinarySearchTreeTests {
	@Test("Minimum absolute difference in BST", arguments: [
		TestCase(given: [4, 2, 6, 1, 3], expected: 1),
		TestCase(given: [1, 0, 48, nil, nil, 12, 49], expected: 1),
	])
	func testGetMinimumDifference(c: TestCase<[Int?], Int>) throws {
		let (root, expected) = (c.given, c.expected)

		let nodes = root.compactMap(\.self)
		try #require(nodes.count >= 2)
		try #require(nodes.allSatisfy { $0 >= 0 })

		let tree = TreeNode(root)
		#expect(getMinimumDifference(tree) == expected)
	}
}
