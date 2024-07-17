import Testing
@testable import LeetCode

@Suite("Sliding Window")
struct SlidingWindowTests {
	@Test("Minimum size subarray sum", arguments: [
		TestCase(given: Pair(7, [2, 3, 1, 2, 4, 3]), expected: 2),
		TestCase(given: Pair(4, [1, 4, 4]), expected: 1),
		TestCase(given: Pair(11, [1, 1, 1, 1, 1, 1, 1, 1]), expected: 0),
	])
	func testMinimumSizeSubarraySum(c: TestCase<Pair<Int, [Int]>, Int>) throws {
		let ((target, nums), expected) = (c.given.values, c.expected)

		try #require(target >= 1)
		try #require(!nums.isEmpty)
		try #require(nums.min()! >= 1)

		#expect(minSubArrayLen(target, nums) == expected)
	}
}
