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
		TestCase(given: Pair("badc", "baba"), expected: false),
	])
	func testIsIsomorphic(c: TestCase<Pair<String, String>, Bool>) throws {
		let ((s, t), expected) = (c.given.values, c.expected)

		try #require(!s.isEmpty && s.count == t.count)
		try #require(s.allSatisfy { $0.isASCII })
		try #require(t.allSatisfy { $0.isASCII })

		#expect(isIsomorphic(s, t) == expected)
	}

	@Test("Word pattern", arguments: [
		TestCase(given: Pair("abba", "dog cat cat dog"), expected: true),
		TestCase(given: Pair("abba", "dog cat cat fish"), expected: false),
		TestCase(given: Pair("aaaa", "dog cat cat dog"), expected: false),
	])
	func testWordPattern(c: TestCase<Pair<String, String>, Bool>) throws {
		let ((pattern, s), expected) = (c.given.values, c.expected)

		try #require(pattern.count >= 1 && pattern.count <= 300)
		try #require(pattern.allSatisfy { c in
			c.isLetter && c.isLowercase
		})

		try #require(s.count >= 1 && s.count <= 3000)
		try #require(s.allSatisfy { c in
			c.isLetter && c.isLowercase || c == " "
		})
		try #require(s.wholeMatch(of: /^\S+(\s\S+)*$/) != nil)

		#expect(wordPattern(pattern, s) == expected)
	}
}
