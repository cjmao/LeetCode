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

		#expect(letterCombinations(digits) == expected)
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
	])
	func testCombine(c: TestCase<Pair<Int, Int>, [[Int]]>) throws {
		let ((n, k), expected) = (c.given.values, c.expected)

		try #require(1 <= n && n <= 20)
		try #require(1 <= k && k <= n)

		#expect(combine(n, k) == expected)
	}
}
