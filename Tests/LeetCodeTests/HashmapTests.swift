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

	@Test("Isomorphic strings", arguments: [
		TestCase(given: Pair("egg", "add"), expected: true),
		TestCase(given: Pair("foo", "bar"), expected: false),
		TestCase(given: Pair("paper", "title"), expected: true),
	])
	func testIsIsomorphic(c: TestCase<Pair<String, String>, Bool>) throws {
		let ((s, t), expected) = (c.given.values, c.expected)

		try #require(!s.isEmpty && s.count == t.count)
		try #require(s.allSatisfy { $0.isASCII })
		try #require(t.allSatisfy { $0.isASCII })

		#expect(isIsomorphic(s, t) == expected)
	}
}
