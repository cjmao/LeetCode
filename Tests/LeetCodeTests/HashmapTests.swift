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
		TestCase(given: Pair("abba", "dog dog dog dog"), expected: false),
		TestCase(given: Pair("aaa", "aa aa aa aa"), expected: false),
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

	@Test("Valid anagram", arguments: [
		TestCase(given: Pair("anagram", "nagaram"), expected: true),
		TestCase(given: Pair("rat", "car"), expected: false),
	])
	func testIsAnagram(c: TestCase<Pair<String, String>, Bool>) throws {
		let ((s, t), expected) = (c.given.values, c.expected)

		try #require(!s.isEmpty && !t.isEmpty)
		try #require([s, t].allSatisfy {s in
			s.allSatisfy { c in
				c.isLetter && c.isLowercase
			}
		})

		#expect(isAnagram(s, t) == expected)
	}

	@Test("Group anagrams", arguments: [
		TestCase(
			given: ["eat", "tea", "tan", "ate", "nat", "bat"],
			expected: [["bat"], ["nat", "tan"], ["ate", "eat","tea"]]
		),
		TestCase(given: [""], expected: [[""]]),
		TestCase(given: ["a"], expected: [["a"]]),
		TestCase(given: ["", ""], expected: [["", ""]]),
	])
	func testGroupAnagrams(c: TestCase<[String], [[String]]>) throws {
		let (strs, expected) = (c.given, c.expected)

		try #require(!strs.isEmpty)
		try #require(strs.allSatisfy { s in
			s.count <= 100 && s.allSatisfy { c in
				c.isLetter && c.isLowercase
			}
		})

		#expect(Set(
			groupAnagrams(strs).map { $0.sorted() }
		) == Set(
			expected.map { $0.sorted() }
		))
	}

	@Test("Two sum", arguments: [
		TestCase(given: Pair([2, 7, 11, 15], 9), expected: [0, 1]),
		TestCase(given: Pair([3, 2, 4], 6), expected: [1, 2]),
		TestCase(given: Pair([3, 3], 6), expected: [0, 1]),
	])
	func testTwoSum(c: TestCase<Pair<[Int], Int>, [Int]>) throws {
		let ((nums, target), expected) = (c.given.values, c.expected)
		try #require(nums.count >= 2)
		#expect(twoSum(nums, target) == expected)
	}
}
