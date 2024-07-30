import Testing
@testable import LeetCode

@Suite("Hashmap")
struct HashmapTests {
	@Test("Ransom note", arguments: [
		TestCase(given: Pair("a", "b"), expected: false),
		TestCase(given: Pair("aa", "ab"), expected: false),
		TestCase(given: Pair("aa", "aab"), expected: true),
	])
	func testCanConstruct(c: TestCase<Pair<String, String>, Bool>) throws {
		let ((note, magazine), expected) = (c.given.values, c.expected)

		try #require(!note.isEmpty && !magazine.isEmpty)
		try #require(note.allSatisfy { c in
			c.isLetter && c.isLowercase
		})
		try #require(magazine.allSatisfy { c in
			c.isLetter && c.isLowercase
		})

		#expect(canConstruct(note, magazine) == expected)
	}
}
