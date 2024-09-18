import Testing
@testable import LeetCode

@Suite("Divide & Conquer")
struct DivideAndConquerTests {
	@Test("Convert sorted array to binary search tree", arguments: [
		TestCase(
			given: [-10, -3, 0, 5, 9],
			expected: [0, -3, 9, -10, nil, 5]
		),
		TestCase(
			given: [1, 3],
			expected: [3, 1]
		),
	])
	func testSortedArrayToBST(c: TestCase<[Int], [Int?]>) throws {
		let (nums, expected) = (c.given, c.expected)

		try #require(!nums.isEmpty)

		let tree = sortedArrayToBST(nums)
		let expectedTree = try #require(TreeNode(expected))

		#expect(isSameTree(tree, expectedTree))
	}
}
