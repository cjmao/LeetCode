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

	@Test("Average of levels in binary tree", arguments: [
		TestCase(given: [3, 9, 20, nil, nil, 15, 7], expected: [3, 14.5, 11]),
		TestCase(given: [3, 9, 20, 15, 7], expected: [3, 14.5, 11]),
	])
	func testAverageOfLevels(c: TestCase<[Int?], [Double]>) throws {
		let (root, expected) = (c.given, c.expected)

		let nodes = root.compactMap(\.self)
		try #require(!nodes.isEmpty)

		let tree = TreeNode(root)
		#expect(averageOfLevels(tree) == expected)
	}

	@Test("Binary tree level order traversal", arguments: [
		TestCase(
			given: [3, 9, 20, nil, nil, 15, 7],
			expected: [[3], [9, 20], [15, 7]]
		),
		TestCase(given: [1], expected: [[1]]),
		TestCase(given: [], expected: []),
	])
	func testLevelOrder(c: TestCase<[Int?], [[Int]]>) throws {
		let (root, expected) = (c.given, c.expected)

		let nodes = root.compactMap(\.self)
		try #require(nodes.count <= 2000)
		try #require(nodes.allSatisfy { $0 >= -1000 && $0 <= 1000 })

		let tree = TreeNode(root)
		#expect(levelOrder(tree) == expected)
	}

	@Test("Binary tree zigzag level order traversal", arguments: [
		TestCase(
			given: [3, 9, 20, nil, nil, 15, 7],
			expected: [[3], [20, 9], [15, 7]]
		),
		TestCase(given: [1], expected: [[1]]),
		TestCase(given: [], expected: []),
	])
	func testZigzagLevelOrder(c: TestCase<[Int?], [[Int]]>) throws {
		let (root, expected) = (c.given, c.expected)

		let nodes = root.compactMap(\.self)
		try #require(nodes.count <= 2000)
		try #require(nodes.allSatisfy { $0 >= -1000 && $0 <= 1000 })

		let tree = TreeNode(root)
		#expect(zigzagLevelOrder(tree) == expected)
	}
}
