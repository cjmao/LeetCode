import Testing
@testable import LeetCode

@Suite("Sliding Window")
struct SlidingWindowTests {
	@Test("Minimum size subarray sum", arguments: [
		TestCase(given: Pair(7, [2, 3, 1, 2, 4, 3]), expected: 2),
		TestCase(given: Pair(4, [1, 4, 4]), expected: 1),
		TestCase(given: Pair(11, [1, 1, 1, 1, 1, 1, 1, 1]), expected: 0),
		TestCase(given: Pair(15, [5, 1, 3, 5, 10, 7, 4, 9, 2, 8]), expected: 2),
		TestCase(given: Pair(5, [2, 3, 1, 1, 1, 1, 1]), expected: 2),
	])
	func testMinimumSizeSubarraySum(c: TestCase<Pair<Int, [Int]>, Int>) throws {
		let ((target, nums), expected) = (c.given.values, c.expected)

		try #require(target >= 1)
		try #require(!nums.isEmpty)
		try #require(nums.min()! >= 1)

		#expect(minSubArrayLen(target, nums) == expected)
	}

	@Test("Longest substring without repeating characters", arguments: [
		TestCase(given: "abcabcbb", expected: 3),
		TestCase(given: "bbbbb", expected: 1),
		TestCase(given: "pwwkew", expected: 3),
	])
	func testLengthOfLongestSubstring(c: TestCase<String, Int>) throws {
		let (s, expected) = (c.given, c.expected)
		try #require(s.allSatisfy { c in
			c.isAlphanumeric || c.isSymbol || c.isWhitespace
		})
		#expect(lengthOfLongestSubstring(s) == expected)
	}
}
