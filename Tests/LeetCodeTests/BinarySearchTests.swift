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

	@Test("Find peak element", arguments: [
		TestCase(given: [1, 2, 3, 1], expected: 2),
		TestCase(given: [1, 2, 1, 3, 5, 6, 4], expected: 5),
		TestCase(given: [1, 2, 3, 4, 3], expected: 3),
		TestCase(given: [3, 4, 3, 2, 1], expected: 1),
		TestCase(given: [1, 2, 1, 2, 1], expected: 1),
	])
	func testFindPeakElement(c: TestCase<[Int], Int>) throws {
		let (nums, expected) = (c.given, c.expected)
		try #require(!nums.isEmpty)
		try #require(zip(nums, nums[1...]).allSatisfy { $0.0 != $0.1 })
		#expect(findPeakElement(nums) == expected)
	}

	@Test("Search in rotated sorted array", arguments: [
		TestCase(given: Pair([4, 5, 6, 7, 0, 1, 2], 0), expected: 4),
		TestCase(given: Pair([4, 5, 6, 7, 0, 1, 2], 3), expected: -1),
		TestCase(given: Pair([1], 0), expected: -1),
		TestCase(given: Pair([1], 1), expected: 0),
		TestCase(given: Pair([3, 1], 1), expected: 1),
		TestCase(given: Pair([3, 1], 3), expected: 0),
	])
	func testSearch(c: TestCase<Pair<[Int], Int>, Int>) throws {
		let ((nums, target), expected) = (c.given.values, c.expected)
		try #require(!nums.isEmpty && Set(nums).count == nums.count)
		#expect(search(nums, target) == expected)
	}

	@Test("Find first and last position of element in sorted array", arguments: [
		TestCase(given: Pair([5, 7, 7, 8, 8, 10], 8), expected: [3, 4]),
		TestCase(given: Pair([5, 7, 7, 8, 8, 10], 6), expected: [-1, -1]),
		TestCase(given: Pair([], 0), expected: [-1, -1]),
	])
	func testSearchRange(c: TestCase<Pair<[Int], Int>, [Int]>) throws {
		let ((nums, target), expected) = (c.given.values, c.expected)
		try #require(nums.isSorted())
		#expect(searchRange(nums, target) == expected)
	}
}
