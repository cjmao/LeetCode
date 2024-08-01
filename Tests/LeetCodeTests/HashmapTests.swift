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

	@Test("Happy number", arguments: [
		TestCase(given: 19, expected: true),
		TestCase(given: 2, expected: false),
	])
	func testIsHappy(c: TestCase<Int, Bool>) throws {
		let (n, expected) = (c.given, c.expected)
		try #require(n >= 1)
		#expect(isHappy(n) == expected)
	}

	@Test("Contains duplicate II", .disabled(), arguments: [
		TestCase(given: Pair([1, 2, 3, 1], 3), expected: true),
		TestCase(given: Pair([1, 0, 1, 1], 1), expected: true),
		TestCase(given: Pair([1, 2, 3, 1, 2, 3], 2), expected: false),
	])
	func testContainsNearbyDuplicate(c: TestCase<Pair<[Int], Int>, Bool>) throws {
		let ((nums, k), expected) = (c.given.values, c.expected)
		try #require(!nums.isEmpty && k >= 0)
		#expect(containsNearbyDuplicate(nums, k) == expected)
	}

	@Test("Longest consecutive sequence", .disabled(), arguments: [
		TestCase(given: [100, 4, 200, 1, 3, 2], expected: 4),
		TestCase(given: [0, 3, 7, 2, 5, 8, 4, 6, 0, 1], expected: 4),
	])
	func testLongestConsecutive(c: TestCase<[Int], Int>) throws {
		let (nums, expected) = (c.given, c.expected)
		#expect(longestConsecutive(nums) == expected)
	}
}
