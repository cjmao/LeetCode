import Testing
@testable import LeetCode

@Suite("Matrix")
struct MatrixTests {
	@Test("Valid Sudoku", arguments: [
		TestCase(
			given: [
				["5","3",".", ".","7",".", ".",".","."],
				["6",".",".", "1","9","5", ".",".","."],
				[".","9","8", ".",".",".", ".","6","."],

				["8",".",".", ".","6",".", ".",".","3"],
				["4",".",".", "8",".","3", ".",".","1"],
				["7",".",".", ".","2",".", ".",".","6"],

				[".","6",".", ".",".",".", "2","8","."],
				[".",".",".", "4","1","9", ".",".","5"],
				[".",".",".", ".","8",".", ".","7","9"]
			],
			expected: true
		),
		TestCase(
			given: [
				["8","3",".", ".","7",".", ".",".","."],
				["6",".",".", "1","9","5", ".",".","."],
				[".","9","8", ".",".",".", ".","6","."],

				["8",".",".", ".","6",".", ".",".","3"],
				["4",".",".", "8",".","3", ".",".","1"],
				["7",".",".", ".","2",".", ".",".","6"],

				[".","6",".", ".",".",".", "2","8","."],
				[".",".",".", "4","1","9", ".",".","5"],
				[".",".",".", ".","8",".", ".","7","9"]
			],
			expected: false
		),
	])
	func testIsValidSudoku(c: TestCase<[[String]], Bool>) throws {
		let (board, expected) = (
			c.given.map { $0.map(Character.init) },
			c.expected
		)

		try #require(board.count == 9)
		try #require(board.allSatisfy { $0.count == 9 })
		try #require(board.allSatisfy { row in
			row.allSatisfy { cell in
				if let number = cell.wholeNumberValue {
					(1...9).contains(number)
				} else {
					cell == "."
				}
			}
		})

		#expect(isValidSudoku(board) == expected)
	}

	@Test("Spiral matrix", arguments: [
		TestCase(
			given: [
				[1, 2, 3],
				[4, 5, 6],
				[7, 8, 9]
			],
			expected: [
				1, 2, 3,
				6, 9, 8,
				7, 4, 5
			]
		),
		TestCase(
			given: [
				[1,  2,  3,  4],
				[5,  6,  7,  8],
				[9, 10, 11, 12]
			],
			expected: [
				1,  2,  3,  4,
				8, 12, 11, 10,
				9,  5,  6,  7
			]
		),
	])
	func testSpiralOrder(c: TestCase<[[Int]], [Int]>) throws {
		let (matrix, expected) = (c.given, c.expected)

		try #require(matrix.count >= 1 && matrix.count <= 10)
		try #require(matrix.allSatisfy { row in
			row.count >= 1 && row.count <= 10 && row.allSatisfy { cell in
				cell >= -100 && cell <= 100
			}
		})

		#expect(spiralOrder(matrix) == expected)
	}
}
