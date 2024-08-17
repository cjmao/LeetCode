import Testing
@testable import LeetCode

@Suite("Binary Tree BFS")
struct BinaryTreeBFSTests {
	@Test("Binary tree right side view", arguments: [
		TestCase(given: [1, 2, 3, nil, 5, nil, 4], expected: [1, 3, 4]),
		TestCase(given: [1, nil, 3], expected: [1, 3]),
		TestCase(given: [], expected: []),
	])
	func testRightSideView(c: TestCase<[Int?], [Int]>) throws {
		let (root, expected) = (c.given, c.expected)

		let nodes = root.compactMap(\.self)
		try #require(nodes.count <= 100)
		try #require(nodes.allSatisfy { $0 >= -100 && $0 <= 100 })

		let tree = TreeNode(root)
		#expect(rightSideView(tree) == expected)
	}
}
