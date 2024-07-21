import Testing
@testable import LeetCode

@Suite("Sliding Window")
struct SlidingWindowTests {
	@Test("Minimum size subarray sum", arguments: [
		TestCase(given: Pair(7, [2, 3, 1, 2, 4, 3]), expected: 2),
		TestCase(given: Pair(4, [1, 4, 4]), expected: 1),
		TestCase(given: Pair(11, [1, 1, 1, 1, 1, 1, 1, 1]), expected: 0),
		TestCase(given: Pair(15, [5, 1, 3, 5, 10, 7, 4, 9, 2, 8]), expected: 2),
		TestCase(given: Pair(5, [2, 3, 1, 1, 1, 1, 1]), expected: 2),
	])
	func testMinimumSizeSubarraySum(c: TestCase<Pair<Int, [Int]>, Int>) throws {
		let ((target, nums), expected) = (c.given.values, c.expected)

		try #require(target >= 1)
		try #require(!nums.isEmpty)
		try #require(nums.min()! >= 1)

		#expect(minSubArrayLen(target, nums) == expected)
	}

	@Test("Longest substring without repeating characters", arguments: [
		TestCase(given: "abcabcbb", expected: 3),
		TestCase(given: "bbbbb", expected: 1),
		TestCase(given: "pwwkew", expected: 3),
		TestCase(given: " ", expected: 1),
		TestCase(given: "aab", expected: 2),
		TestCase(given: "dvdf", expected: 3),
	])
	func testLengthOfLongestSubstring(c: TestCase<String, Int>) throws {
		let (s, expected) = (c.given, c.expected)
		try #require(s.allSatisfy { c in
			c.isAlphanumeric || c.isSymbol || c.isWhitespace
		})
		#expect(lengthOfLongestSubstring(s) == expected)
	}

	@Test("Substring with concatenation of all words", arguments: [
		TestCase(
			given: Pair(
				"barfoothefoobarman",
				["foo", "bar"]
			),
			expected: [0, 9]
		),
		TestCase(
			given: Pair(
				"wordgoodgoodgoodbestword",
				["word", "good", "best", "word"]
			),
			expected: []
		),
		TestCase(
			given: Pair(
				"barfoofoobarthefoobarman",
				["bar", "foo", "the"]
			),
			expected: [6, 9, 12]
		),
		TestCase(
			given: Pair(
				"lingmindraboofooowingdingbarrwingmonkeypoundcake",
				["fooo", "barr", "wing", "ding", "wing"]
			),
			expected: [13]
		),
		TestCase(given: Pair("aaa", ["a", "a"]), expected: [0, 1]),
		TestCase(given: Pair("ababaab", ["ab", "ba", "ba"]), expected: [1]),
		TestCase(
			given: Pair(
				String(repeating: "a", count: 10000),
				[String](repeating: "a", count: 5000)
			),
			expected: Array(0...5000)
		),
		TestCase(
			given: Pair(
				"abbaccaaabcabbbccbabbccabbacabcacbbaabbbbbaaabaccaacbccabcbababbbabccabacbbcabbaacaccccbaabcabaabaaaabcaabcacabaa",
				["cac", "aaa", "aba", "aab", "abc"]
			),
			expected: [97]
		),
	])
	func testFindSubstring(c: TestCase<Pair<String, [String]>, [Int]>) throws {
		let ((s, words), expected) = (c.given.values, c.expected)

		try #require(!s.isEmpty && !words.isEmpty)
		try #require(
			words.allSatisfy { w in
				w.count >= 1 && w.count <= 30 && w.allSatisfy { c in
					c.isLetter && c.isLowercase
				}
			}
		)
		try #require(s.allSatisfy { c in
			c.isLetter && c.isLowercase
		})

		#expect(findSubstring(s, words).sorted() == expected)
	}
}
