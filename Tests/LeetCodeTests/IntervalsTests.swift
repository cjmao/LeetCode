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

	@Test("Merge intervals", arguments: [
		TestCase(
			given: [[1, 3], [2, 6], [8, 10], [15, 18]],
			expected: [[1, 6], [8, 10], [15, 18]]
		),
		TestCase(
			given: [[1, 4], [4, 5]],
			expected: [[1, 5]]
		),
	])
	func testMerge(c: TestCase<[[Int]], [[Int]]>) throws {
		let (intervals, expected) = (c.given, c.expected)

		try #require(!intervals.isEmpty)
		try #require(intervals.allSatisfy { $0.count == 2 })
		try #require(intervals.allSatisfy {
			0 <= $0[0] && $0[0] <= $0[1]
		})

		#expect(merge(intervals) == expected)
	}
}
