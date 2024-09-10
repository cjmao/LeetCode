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
}
