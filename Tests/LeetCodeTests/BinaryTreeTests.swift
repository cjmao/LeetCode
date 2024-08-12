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

	@Test("Same tree", arguments: [
		TestCase(given: Pair([1, 2, 3], [1, 2, 3]), expected: true),
		TestCase(given: Pair([1, 2], [1, nil, 2]), expected: false),
		TestCase(given: Pair([1, 2, 1], [1, 1, 2]), expected: false),
	])
	func testIsSameTree(c: TestCase<Pair<[Int?], [Int?]>, Bool>) throws {
		let ((p, q), expected) = (c.given.values, c.expected)
		let t1 = TreeNode(p)
		let t2 = TreeNode(q)
		try #require(t1 == nil || t1!.size <= 100)
		try #require(t2 == nil || t2!.size <= 100)
		#expect(isSameTree(t1, t2) == expected)
	}

	@Test("Invert binary tree", arguments: [
		TestCase(given: [4, 2, 7, 1, 3, 6, 9], expected: [4, 7, 2, 9, 6, 3, 1]),
		TestCase(given: [2,1,3], expected: [2,3,1]),
		TestCase(given: [], expected: []),
	])
	func testInvertTree(c: TestCase<[Int], [Int]>) throws {
		let (given, expected) = (c.given, c.expected)

		try #require(given.count <= 100 && expected.count <= 100)
		try #require(
			[given, expected].allSatisfy {
				$0.allSatisfy {
					$0 >= -100 && $0 <= 100
				}
			}
		)

		let inverted = invertTree(TreeNode(given))
		let expectedInverted = TreeNode(expected)

		#expect(isSameTree(inverted, expectedInverted))
	}
}
