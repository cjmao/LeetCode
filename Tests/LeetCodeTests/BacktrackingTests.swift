import Testing
@testable import LeetCode

@Suite("Backtracking")
struct BacktrackingTests {
	@Test("Letter combinations of a phone number", arguments: [
		TestCase(
			given: "23",
			expected: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
		),
		TestCase(given: "", expected: []),
		TestCase(given: "2", expected: ["a", "b", "c"]),
	])
	func testLetterCombinations(c: TestCase<String, [String]>) throws {
		let (digits, expected) = (c.given, c.expected)

		try #require(0 <= digits.count && digits.count <= 4)
		try #require(digits.allSatisfy {
			$0.isWholeNumber && $0 != "0" && $0 != "1"
		})

		#expect(letterCombinations(digits).sorted() == expected.sorted())
	}

	@Test("Combinations", arguments: [
		TestCase(
			given: Pair(4, 2),
			expected: [
				[1, 2], [1, 3], [1, 4],
				[2, 3], [2, 4],
				[3, 4]
			]
		),
		TestCase(
			given: Pair(1, 1),
			expected: [[1]]
		),
		TestCase(
			given: Pair(5, 3),
			expected: [
				[1, 2, 3], [1, 2, 4], [1, 2, 5],
				[1, 3, 4], [1, 3, 5],
				[1, 4, 5],
				[2, 3, 4], [2, 3, 5],
				[2, 4, 5],
				[3, 4, 5],
			]
		),
	])
	func testCombine(c: TestCase<Pair<Int, Int>, [[Int]]>) throws {
		let ((n, k), expected) = (c.given.values, Set(c.expected.map(Set.init)))

		try #require(1 <= n && n <= 20)
		try #require(1 <= k && k <= n)

		let combinations = Set(combine(n, k).map(Set.init))

		#expect(combinations == expected)
	}

	@Test("Permutations", arguments: [
		TestCase(
			given: [1, 2, 3],
			expected: [
				[1, 2, 3],
				[1, 3, 2],
				[2, 1, 3],
				[2, 3, 1],
				[3, 1, 2],
				[3, 2, 1],
			]
		),
		TestCase(given: [0, 1], expected: [[0, 1], [1, 0],]),
		TestCase(given: [1], expected: [[1]]),
	])
	func testPermute(c: TestCase<[Int], [[Int]]>) throws {
		let (nums, expected) = (c.given, Set(c.expected))

		try #require(1 <= nums.count && nums.count <= 6)
		try #require(nums.allSatisfy { -10 <= $0 && $0 <= 10 })
		try #require(Set(nums).count == nums.count)

		let permutations = Set(permute(nums))
		#expect(permutations == expected)
	}
}
