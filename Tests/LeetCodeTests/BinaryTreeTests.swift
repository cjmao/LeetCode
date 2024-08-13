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

	@Test("Symmetric tree", arguments: [
		TestCase(given: [1, 2, 2, 3, 4, 4, 3], expected: true),
		TestCase(given: [1, 2, 2, nil, 3, nil, 3], expected: false),
		TestCase(given: [1, 2, 3], expected: false),
	])
	func testIsSymmetric(c: TestCase<[Int?], Bool>) throws {
		let (given, expected) = (c.given, c.expected)
		try #require(given.count >= 1 && given.count <= 1000)
		try #require(given.compactMap(\.self).allSatisfy { $0 >= -100 && $0 <= 100 })
		let root = TreeNode(given)
		#expect(isSymmetric(root) == expected)
	}

	@Test(
		"Construct binary tree from preorder and inorder traversal",
		arguments: [
			TestCase(
				given: Pair([3, 9, 20, 15, 7], [9, 3, 15, 20, 7]),
				expected: [3, 9, 20, nil, nil, 15, 7]
			),
			TestCase(given: Pair([-1], [-1]), expected: [-1]),
		]
	)
	func testBuildTree(c: TestCase<Pair<[Int], [Int]>, [Int?]>) throws {
		let ((preorder, inorder), expected) = (c.given.values, c.expected)

		try #require(preorder.count >= 1 && preorder.count <= 3000)
		try #require(inorder.count == preorder.count)
		try #require([preorder, inorder].allSatisfy {
			$0.allSatisfy {
				$0 >= -3000 && $0 <= 3000
			}
		})
		let items = Set(preorder)
		try #require(items.count == preorder.count)
		try #require(Set(inorder).allSatisfy { items.contains($0) })

		let tree = buildTree(preorder, inorder)
		#expect(isSameTree(tree, TreeNode(expected)))
	}
}
