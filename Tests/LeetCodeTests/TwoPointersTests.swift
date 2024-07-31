import Testing
@testable import LeetCode

@Suite("Two Pointers")
struct TwoPointersTests {
	@Test("Valid palindrome", arguments: [
		TestCase(given: "A man, a plan, a canal: Panama", expected: true),
		TestCase(given: "race a car", expected: false),
		TestCase(given: " ", expected: true),
		TestCase(given: "0P", expected: false),
	])
	func testValidPalindrome(c: TestCase<String, Bool>) throws {
		let (given, expected) = (c.given, c.expected)
		try #require(!given.isEmpty && given.allSatisfy { $0.isASCII })
		#expect(isPalindrome(given) == expected)
	}

	@Test("Is subsequence", arguments: [
		TestCase(given: Pair("abc", "ahbgdc"), expected: true),
		TestCase(given: Pair("axc", "ahbgdc"), expected: false),
	])
	func testIsSubsequence(c: TestCase<Pair<String, String>, Bool>) throws {
		let ((s, t), expected) = (c.given.values, c.expected)

		try #require(s.count <= 100 && t.count <= 10000)
		try #require(s.allSatisfy { $0.isLetter && $0.isLowercase })
		try #require(t.allSatisfy { $0.isLetter && $0.isLowercase })

		#expect(isSubsequence(s, t) == expected)
	}

	@Test("Two sum II - input array is sorted", arguments: [
		TestCase(given: Pair([2, 7, 11, 15], 9), expected: [1, 2]),
		TestCase(given: Pair([2, 3, 4], 6), expected: [1, 3]),
		TestCase(given: Pair([-1, 0], -1), expected: [1, 2]),
	])
	func testTwoSum2(c: TestCase<Pair<[Int], Int>, [Int]>) throws {
		let ((nums, target), expected) = (c.given.values, c.expected)

		try #require(nums.count >= 2 && nums.isSorted())
		try #require(nums.allSatisfy { $0 >= -1000 && $0 <= 1000 })
		try #require(target >= -1000 && target <= 1000)

		#expect(twoSum2(nums, target) == expected)
	}

	@Test("Container with most water", arguments: [
		TestCase(given: [1, 8, 6, 2, 5, 4, 8, 3, 7], expected: 49),
		TestCase(given: [1, 1], expected: 1),
	])
	func testMaxArea(c: TestCase<[Int], Int>) throws {
		let (height, expected) = (c.given, c.expected)

		try #require(height.count >= 2)
		try #require(height.allSatisfy { $0 >= 0 && $0 <= 10000 })

		#expect(maxArea(height) == expected)
	}

	@Test("3 Sum", arguments: [
		TestCase(
			given: [-1, 0, 1, 2, -1, -4],
			expected: [[-1, -1, 2], [-1, 0, 1]]
		),
		TestCase(
			given: [0, 1, 1],
			expected: []
		),
		TestCase(
			given: [0, 0, 0],
			expected: [[0, 0, 0]]
		),
		TestCase(
			given: [1, 2, -2, -1],
			expected: []
		),
		TestCase(
			given: [-1, 0, 1, 2, -1, -4, -2, -3, 3, 0, 4],
			expected: [
				[-4, 0, 4],
				[-4, 1, 3],
				[-3, -1, 4],
				[-3, 0, 3],
				[-3, 1, 2],
				[-2, -1, 3],
				[-2, 0, 2],
				[-1, -1, 2],
				[-1, 0, 1]
			]
		),
		TestCase(
			given: [0, 0, 0, 0],
			expected: [[0, 0, 0]]
		),
	])
	func test3Sum(c: TestCase<[Int], [[Int]]>) throws {
		let (given, expected) = (c.given, c.expected)
		try #require(given.count >= 3)
		#expect(threeSum(given) == expected)
	}
}
