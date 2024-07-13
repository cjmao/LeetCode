import Testing
@testable import LeetCode

extension Array where Element: Comparable {
	func isSorted() -> Bool { self == sorted() }
}

@Suite("Array and String")
struct ArrayAndStringTests {
	@Test("Merge sorted arrays", arguments: [
		TestCase(
			given: Pair([1, 2, 3, 0, 0, 0], [2, 5, 6]),
			expected: [1, 2, 2, 3, 5, 6]
		),
		TestCase(given: Pair([1], []), expected: [1]),
		TestCase(given: Pair([0], [1]), expected: [1]),
	])
	func testMergeSortedArrays(c: TestCase<Pair<[Int], [Int]>, [Int]>) throws {
		var ((a, b), expected) = (c.given.values, c.expected)

		func countExcludingTrailingZeros(_ numbers: [Int]) -> Int {
			if let lastNonZero = numbers.lastIndex(where: { $0 != 0 }) {
				lastNonZero + 1
			} else {
				0
			}
		}

		let (m, n) = (countExcludingTrailingZeros(a), b.count)
		try #require(m >= 0 && n >= 0 && m + n >= 1 && a.count == m + n)

		mergeSortedArrays(&a, m, b, n)
		#expect(a == expected)
	}

	@Test("Remove element", arguments: [
		TestCase(given: Pair(3, [3, 2, 2, 3]), expected: [2, 2]),
		TestCase(
			given: Pair(2, [0, 1, 2, 2, 3, 0, 4, 2]),
			expected: [0, 1, 4, 0, 3]
		),
		TestCase(given: Pair(1, []), expected: []),
		TestCase(given: Pair(1, [2]), expected: [2]),
		TestCase(given: Pair(3, [3, 3]), expected: []),
	])
	func testRemoveElement(c: TestCase<Pair<Int, [Int]>, [Int]>) throws {
		var ((number, nums), expected) = ((c.given.a, c.given.b), c.expected)
		try #require(number >= 0 && number <= 100)

		let k = removeElement(&nums, number)
		#expect(k == expected.count)
		#expect(Set(nums[..<k]) == Set(expected))
	}

	@Test("Remove duplicates from sorted array", arguments: [
		TestCase(given: [1, 1, 2], expected: [1, 2]),
		TestCase(
			given: [0, 0, 1, 1, 1, 2, 2, 3, 3, 4],
			expected: [0, 1, 2, 3, 4]
		),
		TestCase(given: [1], expected: [1]),
		TestCase(given: [1, 1], expected: [1]),
		TestCase(given: [], expected: []),
	])
	func testRemoveDuplicates(c: TestCase<[Int], [Int]>) throws {
		var (nums, expected) = (c.given, c.expected)
		try #require(nums.isSorted() && expected.isSorted())

		let k = removeDuplicates(&nums)
		#expect(k == expected.count)
		#expect(nums[..<k] == expected[...])
	}

	@Test("Remove duplicates from sorted array while keeping at most two", arguments: [
		TestCase(given: [1, 1, 1, 2, 2, 3], expected: [1, 1, 2, 2, 3]),
		TestCase(
			given: [0, 0, 1, 1, 1, 1, 2, 3, 3],
			expected: [0, 0, 1, 1, 2, 3, 3]
		),
		TestCase(given: [], expected: []),
		TestCase(given: [1], expected: [1]),
		TestCase(given: [1, 1], expected: [1, 1]),
		TestCase(given: [1, 1, 1], expected: [1, 1]),
	])
	func testRemoveDuplicatesWhileKeepingAtMostTwo(c: TestCase<[Int], [Int]>) throws {
		var (nums, expected) = (c.given, c.expected)
		try #require(nums.isSorted() && expected.isSorted())

		let k = removeDuplicatesWhileKeepingAtMostTwo(&nums)
		#expect(k == expected.count)
		#expect(nums[..<k] == expected[...])
	}

	@Test("Majority element", arguments: [
		TestCase(given: [3, 2, 3], expected: 3),
		TestCase(given: [2, 2, 1, 1, 1, 2, 2], expected: 2),
	])
	func testMajorityElement(c: TestCase<[Int], Int>) throws {
		let (nums, expected) = (c.given, c.expected)
		let m = majorityElement(nums)
		#expect(m == expected)
	}

	@Test("Rotate array", arguments: [
		TestCase(
			given: Pair(3, [1, 2, 3, 4, 5, 6, 7]),
			expected: [5, 6, 7, 1, 2, 3, 4]
		),
		TestCase(
			given: Pair(2, [-1, -100, 3, 99]),
			expected: [3, 99, -1, -100]
		),
		TestCase(
			given: Pair(1, [1, 2, 3, 4, 5, 6, 7]),
			expected: [7, 1, 2, 3, 4, 5, 6]
		),
	])
	func testRotateArray(c: TestCase<Pair<Int, [Int]>, [Int]>) throws {
		var ((k, nums), expected) = (c.given.values, c.expected)
		try #require(k >= 0 && nums.count > 0)

		rotate(&nums, k)
		#expect(nums == expected)
	}

	@Test("Best time to buy and sell stock", arguments: [
		TestCase(given: [7, 1, 5, 3, 6, 4], expected: 5),
		TestCase(given: [7, 6, 4, 3, 1], expected: 0),
		TestCase(given: [1], expected: 0),
	])
	func testMaxProfit(c: TestCase<[Int], Int>) throws {
		let (prices, expected) = (c.given, c.expected)
		try #require(!prices.isEmpty && prices.allSatisfy { $0 >= 0 })

		let profit = maxProfit(prices)
		#expect(profit == expected)
	}

	@Test("Best time to buy and sell stock II", arguments: [
		TestCase(given: [7, 1, 5, 3, 6, 4], expected: 7),
		TestCase(given: [1, 2, 3, 4, 5], expected: 4),
		TestCase(given: [7, 6, 4, 3, 1], expected: 0),
		TestCase(given: [6, 1, 3, 2, 4, 7], expected: 7),
	])
	func testMaxProfitAllowingSellingOnSameDay(c: TestCase<[Int], Int>) throws {
		let (prices, expected) = (c.given, c.expected)
		try #require(!prices.isEmpty && prices.allSatisfy { $0 >= 0 })

		let profit = maxProfitAllowingSellingOnSameDay(prices)
		#expect(profit == expected)
	}

	@Test("Jump game", arguments: [
		TestCase(given: [2, 3, 1, 1, 4], expected: true),
		TestCase(given: [3, 2, 1, 0, 4], expected: false),
		TestCase(given: [1, 2, 1, 0, 0], expected: false),
		TestCase(given: [1, 2, 3, 4, 0], expected: true),
		TestCase(given: [0], expected: true),
		TestCase(given: [1], expected: true),
	])
	func testJumpGame(c: TestCase<[Int], Bool>) throws {
		let (nums, expected) = (c.given, c.expected)
		try #require(!nums.isEmpty && nums.allSatisfy { $0 >= 0 })

		let result = canJump(nums)
		#expect(result == expected)
	}

	@Test("Jump game II", arguments: [
		TestCase(given: [2, 3, 1, 1, 4], expected: 2),
		TestCase(given: [2, 3, 0, 1, 4], expected: 2),
		TestCase(given: [0], expected: 0),
	])
	func testMinimumStepsOfJumpGame(c: TestCase<[Int], Int>) throws {
		let (nums, expected) = (c.given, c.expected)
		try #require(!nums.isEmpty && nums.allSatisfy { $0 >= 0 })

		let result = jump(nums)
		#expect(result == expected)
	}

	@Test("H-index", arguments: [
		TestCase(given: [3, 0, 6, 1, 5], expected: 3),
		TestCase(given: [1, 3, 1], expected: 1),
		TestCase(given: [0], expected: 0),
		TestCase(given: [1], expected: 1),
		TestCase(given: [100], expected: 1),
		TestCase(given: [4, 4, 0, 0], expected: 2),
	])
	func testHIndex(c: TestCase<[Int], Int>) throws {
		let (nums, expected) = (c.given, c.expected)
		try #require(nums.count > 0 && nums.allSatisfy { $0 >= 0 })

		let h = hIndex(nums)
		#expect(h == expected)
	}

	@Test("Product of array except self", arguments: [
		TestCase(given: [1, 2, 3, 4], expected: [24, 12, 8, 6]),
		TestCase(given: [-1, 1, 0, -3, 3], expected: [0, 0, 9, 0, 0]),
		TestCase(given: [2, 3], expected: [3, 2]),
	])
	func testProductExceptSelf(c: TestCase<[Int], [Int]>) throws {
		let (nums, expected) = (c.given, c.expected)
		try #require(nums.count >= 2 && nums.count == expected.count)

		let product = productExceptSelf(nums)
		#expect(product == expected)
	}

	@Test("Gas station", arguments: [
		TestCase(
			given: Pair([1, 2, 3, 4, 5], [3, 4, 5, 1, 2]),
			expected: 3
		),
		TestCase(
			given: Pair([2, 3, 4], [3, 4, 3]),
			expected: -1
		),
	])
	func testGasStation(c: TestCase<Pair<[Int], [Int]>, Int>) throws {
		let ((gas, cost), expected) = (c.given.values, c.expected)

		try #require(!gas.isEmpty && gas.count == cost.count)
		try #require(gas.allSatisfy { $0 >= 0 })
		try #require(cost.allSatisfy { $0 >= 0 })

		let canComplete = canCompleteCircuit(gas, cost)
		#expect(canComplete == expected)
	}

	@Test("Candy", arguments: [
		TestCase(given: [1, 0, 2], expected: 5),
		TestCase(given: [1, 2, 2], expected: 4),
		TestCase(given: [1, 2, 1, 3, 4, 2], expected: 10),
		TestCase(given: [1, 2, 87, 87, 2, 1], expected: 12),
		TestCase(given: [0, 1, 2, 5, 3, 2, 7], expected: 15),
		TestCase(given: [1, 6, 10, 8, 7, 3, 2], expected: 18),
	])
	func testCandy(c: TestCase<[Int], Int>) throws {
		let (ratings, expected) = (c.given, c.expected)
		try #require(!ratings.isEmpty && ratings.allSatisfy { $0 >= 0 })

		let candies = candy(ratings)
		#expect(candies == expected)
	}

	@Test("Trapping rain water", arguments: [
		TestCase(given: [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1], expected: 6),
		TestCase(given: [4, 2, 0, 3, 2, 5], expected: 9),
		TestCase(given: [4, 2, 3], expected: 1),
	])
	func testTrappingRainWater(c: TestCase<[Int], Int>) throws {
		let (height, expected) = (c.given, c.expected)
		try #require(!height.isEmpty && height.allSatisfy { $0 >= 0 })

		let trappedWater = trap(height)
		#expect(trappedWater == expected)
	}

	@Test("Roman to integer", arguments: [
		TestCase(given: "III", expected: 3),
		TestCase(given: "LVIII", expected: 58),
		TestCase(given: "MCMXCIV", expected: 1994),
	])
	func testRomanToInt(c: TestCase<String, Int>) throws {
		let (roman, expected) = (c.given, c.expected)

		try #require((1...15).contains(roman.count))
		try #require(
			Set(roman.unicodeScalars)
				.isSubset(of: ["I", "V", "X", "L", "C", "D", "M"])
		)

		let number = romanToInt(roman)
		try #require((1...3999).contains(number))

		#expect(number == expected)
	}

	@Test("Integer to Roman", arguments: [
		TestCase(given: 3749, expected: "MMMDCCXLIX"),
		TestCase(given: 58, expected: "LVIII"),
		TestCase(given: 1994, expected: "MCMXCIV"),
	])
	func testIntegerToRoman(c: TestCase<Int, String>) throws {
		let (number, expected) = (c.given, c.expected)

		try #require((1...3999).contains(number))

		let roman = intToRoman(number)
		try #require(
			Set(roman.unicodeScalars)
				.isSubset(of: ["I", "V", "X", "L", "C", "D", "M"])
		)

		#expect(roman == expected)
	}

	@Test("Length of last word", arguments: [
		TestCase(given: "Hello World", expected: 5),
		TestCase(given: "   fly me   to   the moon  ", expected: 4),
		TestCase(given: "luffy is still joyboy", expected: 6),
	])
	func testLengthOfLastWord(c: TestCase<String, Int>) throws {
		let (string, expected) = (c.given, c.expected)

		try #require(string.count >= 1)
		try #require(string.allSatisfy { $0.isLetter || $0 == " " })
		try #require(string.split(separator: " ").count >= 1)

		let length = lengthOfLastWord(string)
		#expect(length == expected)
	}

	@Test("Longest common prefix", arguments: [
		TestCase(given: ["flower", "flow", "flight"], expected: "fl"),
		TestCase(given: ["dog", "racecar", "car"], expected: ""),
		TestCase(given: ["ab", "a"], expected: "a"),
		TestCase(given: ["", "b"], expected: ""),
		TestCase(given: ["c", "acc", "ccc"], expected: ""),
	])
	func testLongestCommonPrefix(c: TestCase<[String], String>) throws {
		let (strings, expected) = (c.given, c.expected)

		try #require(strings.count >= 1)
		try #require(strings.allSatisfy { $0.count >= 0 })

		let length = longestCommonPrefix(strings)
		#expect(length == expected)
	}

	@Test("Reverse words in a string", arguments: [
		TestCase(given: "the sky is blue", expected: "blue is sky the"),
		TestCase(given: "  hello world  ", expected: "world hello"),
		TestCase(given: "a good   example", expected: "example good a"),
	])
	func testReverseWords(c: TestCase<String, String>) throws {
		let (s, expected) = (c.given, c.expected)

		try #require(!s.isEmpty)
		let _ = try #require(
			try #/[[:space:]]*([[:alnum:]]+[[:space:]]*)+/#.wholeMatch(in: s)
		)

		let reversed = reverseWords(s)
		#expect(reversed == expected)
	}

	@Test("Zigzag conversion", arguments: [
		TestCase(given: Pair(3, "PAYPALISHIRING"), expected: "PAHNAPLSIIGYIR"),
		TestCase(given: Pair(4, "PAYPALISHIRING"), expected: "PINALSIGYAHRPI"),
		TestCase(given: Pair(5, "PAYPALISHIRING"), expected: "PHASIYIRPLIGAN"),
		TestCase(given: Pair(1, "A"), expected: "A"),
	])
	func testZigZagConversion(c: TestCase<Pair<Int, String>, String>) throws {
		let ((rows, s), expected) = (c.given.values, c.expected)

		try #require(rows >= 1 && rows <= 1000)
		try #require(!s.isEmpty)
		let _ = try #require(
			try #/([[:alpha:]]|,|\.)+/#.wholeMatch(in: s)
		)

		let converted = convert(s, rows)
		#expect(converted == expected)
	}

	@Test("Find the index of the first occurrence in a string", arguments: [
		TestCase(given: Pair("sadbutsad", "sad"), expected: 0),
		TestCase(given: Pair("leetcode", "leeto"), expected: -1),
		TestCase(given: Pair("aaa", "aaaa"), expected: -1),
		TestCase(given: Pair("mississippi", "issipi"), expected: -1),
	])
	func testFindFirstOccurenceInString(c: TestCase<Pair<String, String>, Int>) throws {
		let ((haystack, needle), expected) = (c.given.values, c.expected)

		try #require(!haystack.isEmpty && !needle.isEmpty)
		try #require(haystack.allSatisfy { $0.isLetter })
		try #require(needle.allSatisfy { $0.isLetter })

		let index = strStr(haystack, needle)
		#expect(index == expected)
	}

	@Test("Text justification", arguments: [
		TestCase(
			given: Pair(16, [
				"This", "is", "an", "example", "of", "text", "justification."
			]),
			expected: [
				"This    is    an",
				"example  of text",
				"justification.  "
			]
		),
		TestCase(
			given: Pair(16, [
				"What", "must", "be", "acknowledgment", "shall", "be"
			]),
			expected: [
				"What   must   be",
				"acknowledgment  ",
				"shall be        "
			]
		),
		TestCase(
			given: Pair(20, [
				"Science", "is", "what", "we", "understand", "well",
				"enough", "to", "explain", "to", "a", "computer.",
				"Art", "is", "everything", "else", "we", "do"
			]),
			expected: [
				"Science  is  what we",
				"understand      well",
				"enough to explain to",
				"a  computer.  Art is",
				"everything  else  we",
				"do                  "
			]
		),
	])
	func testTextJustification(c: TestCase<Pair<Int, [String]>, [String]>) throws {
		let ((maxWidth, words), expected) = (c.given.values, c.expected)

		try #require(maxWidth >= 1 && maxWidth <= 100)
		try #require(!words.isEmpty)
		try #require(
			words.allSatisfy { w in
				w.count >= 1 && w.count <= min(20, maxWidth) && w.allSatisfy {
					c in c.isLetter || c.isSymbol || c.isPunctuation
				}
			}
		)

		let justified = fullJustify(words, maxWidth)
		#expect(justified == expected)
	}
}
