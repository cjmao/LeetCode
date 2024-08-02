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
		TestCase(given: [[1, 4], [4, 5]], expected: [[1, 5]]),
		TestCase(given: [[1, 4], [0, 4]], expected: [[0, 4]]),
		TestCase(given: [[1, 4], [1, 5]], expected: [[1, 5]]),
		TestCase(given: [[1, 4], [2, 3]], expected: [[1, 4]]),
		TestCase(given: [[1, 4], [0, 5]], expected: [[0, 5]]),
		TestCase(
			given: [[2, 3], [4, 5], [6, 7], [8, 9], [1, 10]],
			expected: [[1, 10]]
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

	@Test("Insert interval", arguments: [
		TestCase(
			given: Pair(
				[[1, 3], [6, 9]],
				[2, 5]
			),
			expected: [[1, 5], [6, 9]]
		),
		TestCase(
			given: Pair(
				[[1, 2], [3, 5], [6, 7], [8, 10], [12, 16]],
				[4, 8]
			),
			expected: [[1, 2], [3, 10], [12, 16]]
		),
	])
	func testInsert(c: TestCase<Pair<[[Int]], [Int]>, [[Int]]>) throws {
		let ((intervals, newInterval), expected) = (c.given.values, c.expected)

		try #require(intervals.allSatisfy { $0.count == 2 })
		try #require(intervals.allSatisfy {
			0 <= $0[0] && $0[0] <= $0[1]
		})
		try #require(intervals == intervals.sorted(by: { a, b in
			a[0] <= b[0]
		}))
		try #require(newInterval.count == 2)

		#expect(insert(intervals, newInterval) == expected)
	}

	@Test("Minimum number of arrows to burst balloons", arguments: [
		TestCase(given: [[10, 16], [2, 8], [1, 6], [7, 12]], expected: 2),
		TestCase(given: [[1, 2], [3, 4], [5, 6], [7, 8]], expected: 4),
		TestCase(given: [[1, 2], [2, 3], [3, 4], [4, 5]], expected: 2),
	])
	func testFindMinArrowShots(c: TestCase<[[Int]], Int>) throws {
		let (points, expected) = (c.given, c.expected)

		try #require(!points.isEmpty)
		try #require(points.allSatisfy { $0.count == 2 })

		#expect(findMinArrowShots(points) == expected)
	}
}
