import Testing
@testable import LeetCode

@Suite("Two Pointers")
struct TwoPointersTests {
	@Test("Valid palindrome", arguments: [
		TestCase(given: "A man, a plan, a canal: Panama", expected: true),
		TestCase(given: "race a car", expected: false),
		TestCase(given: " ", expected: true),
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
}
