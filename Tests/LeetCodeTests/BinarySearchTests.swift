import Testing
@testable import LeetCode

@Suite("Binary Search")
struct BinarySearchTests {
	@Test("Search insert position", arguments: [
		TestCase(given: Pair([1, 3, 5, 6], 5), expected: 2),
		TestCase(given: Pair([1, 3, 5, 6], 2), expected: 1),
		TestCase(given: Pair([1, 3, 5, 6], 7), expected: 4),
	])
	func testSearchInsert(c: TestCase<Pair<[Int], Int>,  Int>) throws {
		let ((nums, target), expected) = (c.given.values, c.expected)

		try #require(!nums.isEmpty)
		try #require(Set(nums).count == nums.count)
		try #require(nums.isSorted())

		#expect(searchInsert(nums, target) == expected)
	}

	@Test("Search a 2D matrix", arguments: [
		TestCase(
			given: Pair([
				[ 1,  3,  5,  7],
				[10, 11, 16, 20],
				[23, 30, 34, 60]
			], 3),
			expected: true
		),
		TestCase(
			given: Pair([
				[ 1,  3,  5,  7],
				[10, 11, 16, 20],
				[23, 30, 34, 60]
			], 13),
			expected: false
		),
	])
	func testSearchMatrix(c: TestCase<Pair<[[Int]], Int>, Bool>) throws {
		let ((matrix, target), expected) = (c.given.values, c.expected)
		let (m, n) = (matrix.count, matrix[0].count)
		try #require([m, n].allSatisfy { 1 <= $0 && $0 <= 100 })
		#expect(searchMatrix(matrix, target) == expected)
	}
}
