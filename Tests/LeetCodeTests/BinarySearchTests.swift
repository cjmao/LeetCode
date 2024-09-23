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
}
