import Testing
@testable import LeetCode

@Suite("Intervals")
struct IntervalsTests {
	@Test("Summary ranges", arguments: [
		TestCase(
			given: [0, 1, 2, 4, 5, 7],
			expected: ["0->2", "4->5", "7"]
		),
		TestCase(
			given: [0, 2, 3, 4, 6, 8, 9],
			expected: ["0", "2->4", "6", "8->9"]
		),
	])
	func testSummaryRanges(c: TestCase<[Int], [String]>) throws {
		let (nums, expected) = (c.given, c.expected)

		try #require(nums.count >= 0 && nums.count <= 20)
		try #require(nums.count == Set(nums).count)
		try #require(nums == nums.sorted())

		#expect(summaryRanges(nums) == expected)
	}
}
