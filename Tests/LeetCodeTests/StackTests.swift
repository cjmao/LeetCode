import Testing
@testable import LeetCode

@Suite("Stack")
struct StackTests {
	@Test("Valid parentheses", arguments: [
		TestCase(given: "()", expected: true),
		TestCase(given: "()[]{}", expected: true),
		TestCase(given: "(]", expected: false),
	])
	func testValidParentheses(c: TestCase<String, Bool>) throws {
		let (s, expected) = (c.given, c.expected)
		let characters = Set("()[]{}")
		try #require(!s.isEmpty && s.allSatisfy { characters.contains($0) })
		#expect(isValid(s) == expected)
	}
}
