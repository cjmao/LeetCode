import Testing
@testable import LeetCode

@Suite("Kadane's Algorithm")
struct KadanesAlgorithmTests {
	@Test("Maximum subarray", arguments: [
		TestCase(given: [-2, 1, -3, 4, -1, 2, 1, -5, 4], expected: 6),
		TestCase(given: [1], expected: 1),
		TestCase(given: [5, 4, -1, 7, 8], expected: 23),
	])
	func testMaxSubArray(c: TestCase<[Int], Int>) throws {
		let (nums, expected) = (c.given, c.expected)
		try #require(!nums.isEmpty)
		#expect(maxSubArray(nums) == expected)
	}

	@Test("Maximum sum circular subarray", arguments: [
		TestCase(given: [1, -2, 3, -2], expected: 3),
		TestCase(given: [5, -3, 5], expected: 10),
		TestCase(given: [-3, -2, -3], expected: -2),
	])
	func testMaxSubarraySumCircular(c: TestCase<[Int], Int>) throws {
		let (nums, expected) = (c.given, c.expected)
		try #require(!nums.isEmpty)
		#expect(maxSubarraySumCircular(nums) == expected)
	}
}
