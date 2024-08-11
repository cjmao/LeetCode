import Testing
@testable import LeetCode

@Suite("Binary Tree General")
struct BinaryTreeTests {
	@Test("Maximum depth of binary tree", arguments: [
		TestCase(given: [3, 9, 20, nil, nil, 15, 7], expected: 3),
		TestCase(given: [1, nil, 2], expected: 2),
		TestCase(given: [], expected: 0),
	])
	func testMaxDepth(c: TestCase<[Int?], Int>) throws {
		let (given, expected) = (c.given, c.expected)
		try #require(given.compactMap(\.self).allSatisfy { $0 >= -100 && $0 <= 100 })
		let root = TreeNode(given)
		#expect(maxDepth(root) == expected)
	}
}
