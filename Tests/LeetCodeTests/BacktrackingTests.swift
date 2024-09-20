import Testing
@testable import LeetCode

@Suite("Backtracking")
struct BacktrackingTests {
	@Test("Letter combinations of a phone number", arguments: [
		TestCase(
			given: "23",
			expected: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
		),
		TestCase(given: "", expected: []),
		TestCase(given: "2", expected: ["a", "b", "c"]),
	])
	func testLetterCombinations(c: TestCase<String, [String]>) throws {
		let (digits, expected) = (c.given, c.expected)

		try #require(0 <= digits.count && digits.count <= 4)
		try #require(digits.allSatisfy {
			$0.isWholeNumber && $0 != "0" && $0 != "1"
		})

		#expect(letterCombinations(digits).sorted() == expected.sorted())
	}

	@Test("Combinations", arguments: [
		TestCase(
			given: Pair(4, 2),
			expected: [
				[1, 2], [1, 3], [1, 4],
				[2, 3], [2, 4],
				[3, 4]
			]
		),
		TestCase(
			given: Pair(1, 1),
			expected: [[1]]
		),
		TestCase(
			given: Pair(5, 3),
			expected: [
				[1, 2, 3], [1, 2, 4], [1, 2, 5],
				[1, 3, 4], [1, 3, 5],
				[1, 4, 5],
				[2, 3, 4], [2, 3, 5],
				[2, 4, 5],
				[3, 4, 5],
			]
		),
	])
	func testCombine(c: TestCase<Pair<Int, Int>, [[Int]]>) throws {
		let ((n, k), expected) = (c.given.values, Set(c.expected.map(Set.init)))

		try #require(1 <= n && n <= 20)
		try #require(1 <= k && k <= n)

		let combinations = Set(combine(n, k).map(Set.init))

		#expect(combinations == expected)
	}

	@Test("Permutations", arguments: [
		TestCase(
			given: [1, 2, 3],
			expected: [
				[1, 2, 3],
				[1, 3, 2],
				[2, 1, 3],
				[2, 3, 1],
				[3, 1, 2],
				[3, 2, 1],
			]
		),
		TestCase(given: [0, 1], expected: [[0, 1], [1, 0],]),
		TestCase(given: [1], expected: [[1]]),
	])
	func testPermute(c: TestCase<[Int], [[Int]]>) throws {
		let (nums, expected) = (c.given, Set(c.expected))

		try #require(1 <= nums.count && nums.count <= 6)
		try #require(nums.allSatisfy { -10 <= $0 && $0 <= 10 })
		try #require(Set(nums).count == nums.count)

		let permutations = Set(permute(nums))
		#expect(permutations == expected)
	}

	@Test("Combination sum", arguments: [
		TestCase(
			given: Pair([2, 3, 6, 7], 7),
			expected: [[2, 2, 3], [7]]
		),
		TestCase(
			given: Pair([2, 3, 5], 8),
			expected: [[2, 2, 2, 2], [2, 3, 3], [3, 5]]
		),
		TestCase(
			given: Pair([2], 1),
			expected: []
		),
	])
	func testCombinationSum(c: TestCase<Pair<[Int], Int>, [[Int]]>) throws {
		let ((candidates, target), expected) = (c.given.values, Set(c.expected))

		try #require(1 <= candidates.count && candidates.count <= 30)
		try #require(candidates.allSatisfy { 2 <= $0 && $0 <= 40 })
		try #require(Set(candidates).count == candidates.count)
		try #require(1 <= target && target <= 40)

		let combinations = Set(combinationSum(candidates, target))
		#expect(combinations == expected)
	}

	@Test("N-Queens II", arguments: [
		TestCase(given: 1, expected: 1),
		TestCase(given: 2, expected: 0),
		TestCase(given: 3, expected: 0),
		TestCase(given: 4, expected: 2),
		TestCase(given: 5, expected: 10),
		TestCase(given: 6, expected: 4),
		TestCase(given: 7, expected: 40),
		TestCase(given: 8, expected: 92),
		TestCase(given: 9, expected: 352),
	])
	func testTotalNQueens(c: TestCase<Int, Int>) throws {
		let (n, expected) = (c.given, c.expected)
		try #require(1 <= n && n <= 9)
		#expect(totalNQueens(n) == expected)
	}

	@Test("Generate parentheses", arguments: [
		TestCase(given: 1, expected: ["()"]),
		TestCase(given: 2, expected: ["(())", "()()"]),
		TestCase(
			given: 3,
			expected: [
				"((()))",
				"(()())",
				"(())()",
				"()(())",
				"()()()"
			]
		),
		TestCase(given: 4, expected: [
			"(((())))",
			"((()()))",
			"((())())",
			"((()))()",
			"(()(()))",
			"(()()())",
			"(()())()",
			"(())(())",
			"(())()()",
			"()((()))",
			"()(()())",
			"()(())()",
			"()()(())",
			"()()()()"
		]),
	])
	func testGenerateParenthesis(c: TestCase<Int, [String]>) throws {
		let (n, expected) = (c.given, c.expected)
		try #require(1 <= n && n <= 8)
		#expect(generateParenthesis(n) == expected)
	}

	@Test("Word search", arguments: [
		TestCase(
			given: Pair([
				["A", "B", "C", "E"],
				["S", "F", "C", "S"],
				["A", "D", "E", "E"]
			], "ABCCED"),
			expected: true
		),
		TestCase(
			given: Pair([
				["A", "B", "C", "E"],
				["S", "F", "C", "S"],
				["A", "D", "E", "E"]
			], "SEE"),
			expected: true
		),
		TestCase(
			given: Pair([
				["A", "B", "C", "E"],
				["S", "F", "C", "S"],
				["A", "D", "E", "E"]
			], "ABCB"),
			expected: false
		),
		TestCase(
			given: Pair([["a"]], "a"),
			expected: true
		),
		TestCase(
			given: Pair([
				["a", "b"],
				["c", "d"],
			], "acdb"),
			expected: true
		),
		TestCase(
			given: Pair([
				["a", "a"],
			], "aaa"),
			expected: false
		),
		TestCase(
			given: Pair([
				["a", "b"],
			], "ba"),
			expected: true
		),
	])
	func testExist(c: TestCase<Pair<[[String]], String>, Bool>) throws {
		let ((board, word), expected) = (c.given.values, c.expected)
		let (m, n) = (board.count, board[0].count)

		try #require([m, n].allSatisfy { 1 <= $0 && $0 <= 6 })
		try #require(1 <= word.count && word.count <= 15)
		try #require(
			board.allSatisfy {
				$0.allSatisfy {
					$0.count == 1 && $0.first!.isLetter
				}
			}
			&& word.allSatisfy(\.isLetter)
		)

		let b = board.map { $0.map(\.first!) }
		#expect(exist(b, word) == expected)
	}
}
