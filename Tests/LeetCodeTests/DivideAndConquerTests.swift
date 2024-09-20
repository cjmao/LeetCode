import Testing
import Foundation
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

	@Test("Sort list", arguments: [
		TestCase(given: [4, 2, 1, 3], expected: [1, 2, 3, 4]),
		TestCase(given: [-1, 5, 3, 4, 0], expected: [-1, 0, 3, 4, 5]),
		TestCase(given: [], expected: []),
	])
	func testSortList(c: TestCase<[Int], [Int]>) throws {
		let (nums, expected) = (c.given, c.expected)

		let givenList = LinkedList(nums)
		let expectedList = LinkedList(expected)

		#expect(givenList == expectedList)
	}

	@Test("Construct quad tree", arguments: [
		TestCase(
			given: [
				[0, 1],
				[1, 0]
			],
			expected: [
				[0, 1],
				[1, 0], [1, 1],
				[1, 1], [1, 0]
			]
		),
		TestCase(
			given: [
				[1, 1, 1, 1,  0, 0, 0, 0],
				[1, 1, 1, 1,  0, 0, 0, 0],
				[1, 1, 1, 1,  1, 1, 1, 1],
				[1, 1, 1, 1,  1, 1, 1, 1],

				[1, 1, 1, 1,  0, 0, 0, 0],
				[1, 1, 1, 1,  0, 0, 0, 0],
				[1, 1, 1, 1,  0, 0, 0, 0],
				[1, 1, 1, 1,  0, 0, 0, 0],
			],
			expected: [
				[0, 1],
				[1, 1], [0, 1],
				[1, 1], [1, 0],
				[1, 0], [1, 0],
				[1, 1], [1, 1]
			]
		),
	])
	func testConstruct(c: TestCase<[[Int]], [[Int]]>) throws {
		let (grid, expected) = (c.given, c.expected)
		let n = grid.count, x = log2(Double(n))

		try #require(grid.allSatisfy { $0.count == n })
		try #require(0 <= x && x <= 6)

		let levels = try #require(construct(grid)).levels()
			.flatMap { level in
				level.map { node in
					[node.isLeaf ? 1 : 0, node.val ? 1 : 0]
				}
			}

		#expect(levels == expected)
	}

	@Test("Merge k sorted lists", arguments: [
		TestCase(
			given: [[1, 4, 5], [1, 3, 4], [2, 6]],
			expected: [1, 1, 2, 3, 4, 4, 5, 6]
		),
		TestCase(
			given: [],
			expected: []
		),
		TestCase(
			given: [[]],
			expected: []
		),
	])
	func testMergeKLists(c: TestCase<[[Int]], [Int]>) throws {
		let (nodes, expected) = (c.given, c.expected)

		try #require(nodes.allSatisfy {
			0 <= $0.count && $0.count <= 500 && $0.isSorted()
		})

		let lists = nodes.map { LinkedList($0).head }
		let merged = mergeKLists(lists)

		if expected.isEmpty {
			#expect(merged == nil)
		} else {
			let merged = try #require(merged)
			let s = sequence(first: merged, next: \.next).map(\.val)
			#expect(s == expected)
		}
	}
}
