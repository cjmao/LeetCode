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
		TestCase(
			given: [
				[ 1,  2,  3,  4],
				[ 5,  6,  7,  8],
				[ 9, 10, 11, 12],
				[13, 14, 15, 16]
			],
			expected: [
				1,   2,  3,  4,
				8,  12, 16, 15,
				14, 13,  9,  5,
				6,   7, 11, 10
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

	@Test("Rotate image", arguments: [
		TestCase(
			given: [
				[1, 2, 3],
				[4, 5, 6],
				[7, 8, 9]
			],
			expected: [
				[7, 4, 1],
				[8, 5, 2],
				[9, 6, 3]
			]
		),
		TestCase(
			given: [
				[ 5,  1,  9, 11],
				[ 2,  4,  8, 10],
				[13,  3,  6,  7],
				[15, 14, 12, 16]
			],
			expected: [
				[15, 13,  2,  5],
				[14,  3,  4,  1],
				[12,  6,  8,  9],
				[16,  7, 10, 11]
			]
		),
	])
	func testRotate(c: TestCase<[[Int]], [[Int]]>) throws {
		var (matrix, expected) = (c.given, c.expected)

		try #require(matrix.count >= 1 && matrix.count <= 20)
		try #require(matrix.allSatisfy { row in
			row.count == matrix.count && row.allSatisfy { cell in
				cell >= -1000 && cell <= 1000
			}
		})

		rotate(&matrix)
		#expect(matrix == expected)
	}

	@Test("Set matrix zeroes", arguments: [
		TestCase(
			given: [
				[1, 1, 1],
				[1, 0, 1],
				[1, 1, 1]
			],
			expected: [
				[1, 0, 1],
				[0, 0, 0],
				[1, 0, 1]
			]
		),
		TestCase(
			given: [
				[0, 1, 2, 0],
				[3, 4, 5, 2],
				[1, 3, 1, 5]
			],
			expected: [
				[0, 0, 0, 0],
				[0, 4, 5, 0],
				[0, 3, 1, 0]
			]
		),
	])
	func testSetZeroes(c: TestCase<[[Int]], [[Int]]>) throws {
		var (matrix, expected) = (c.given, c.expected)

		try #require(matrix.count >= 1 && matrix.count <= 200)
		try #require(matrix.allSatisfy { row in
			row.count >= 1 && row.count <= 200
		})

		setZeroes(&matrix)
		#expect(matrix == expected)
	}

	@Test("Game of life", arguments: [
		TestCase(
			given: [
				[0, 1, 0],
				[0, 0, 1],
				[1, 1, 1],
				[0, 0, 0]
			],
			expected: [
				[0, 0, 0],
				[1, 0, 1],
				[0, 1, 1],
				[0, 1, 0]
			]
		),
		TestCase(
			given: [
				[1, 1],
				[1, 0]
			],
			expected: [
				[1, 1],
				[1, 1]
			]
		),
	])
	func testGameOfLife(c: TestCase<[[Int]], [[Int]]>) throws {
		var (board, expected) = (c.given, c.expected)

		try #require(board.count >= 1 && board.count <= 25)
		try #require(board.allSatisfy { row in
			row.count >= 1 && row.count <= 25 && row.allSatisfy { cell in
				cell == 0 || cell == 1
			}
		})

		gameOfLife(&board)
		#expect(board == expected)
	}
}
