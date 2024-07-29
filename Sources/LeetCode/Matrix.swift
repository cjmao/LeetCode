/// Valid Sudoku
///
/// Determine if a `9 x 9` Sudoku board is valid. Only the filled cells need to
/// be validated **according to the following rules**:
///
/// 1. Each row must contain the digits `1-9` without repetition.
/// 1. Each column must contain the digits `1-9` without repetition.
/// 1. Each of the nine `3 x 3` sub-boxes of the grid must contain the digits
/// `1-9` without repetition.
///
/// **Note**:
///
/// - A Sudoku board (partially filled) could be valid but is not necessarily
///   solvable.
/// - Only the filled cells need to be validated according to the mentioned
///   rules.
func isValidSudoku(_ board: [[Character]]) -> Bool {
	var rows: [Set<Int>] = [_](repeating: [], count: 9)
	var columns: [Set<Int>] = [_](repeating: [], count: 9)
	var grids: [Set<Int>] = [_](repeating: [], count: 9)

	for (i, row) in board.enumerated() {
		for (j, cell) in row.enumerated() {
			guard let number = cell.wholeNumberValue else {
				continue
			}

			let gridIndex = (i / 3) * 3 + j / 3

			if rows[i].contains(number)
				|| columns[j].contains(number)
				|| grids[gridIndex].contains(number) {
				return false
			}

			rows[i].insert(number)
			columns[j].insert(number)
			grids[gridIndex].insert(number)
		}
	}

	return true
}

/// Spiral matrix
///
/// Given an `m x n` `matrix`, return *all elements of the `matrix` in spiral
/// order*.
func spiralOrder(_ matrix: [[Int]]) -> [Int] {
	var spiral = [Int]()

	let (m, n) = (matrix.count, matrix[0].count)
	let movements = [
		( 0,  1), // right
		( 1,  0), // down
		( 0, -1), // left
		(-1,  0), // up
	]
	var currentMovement = 0
	var rowLimits = (low: 0, high: m)
	var columnLimits = (low: 0, high: n)

	var r = 0, c = 0

	while spiral.count < m * n {
		spiral.append(matrix[r][c])

		var (dr, dc) = movements[currentMovement]

		if currentMovement == 0, c + dc >= columnLimits.high {
			currentMovement = 1
			rowLimits.low += 1
		} else if currentMovement == 1, r + dr >= rowLimits.high {
			currentMovement = 2
			columnLimits.high -= 1
		} else if currentMovement == 2, c + dc < columnLimits.low {
			currentMovement = 3
			columnLimits.low += 1
		} else if currentMovement == 3, r + dr < rowLimits.low {
			currentMovement = 0
			rowLimits.high -= 1
		}

		(dr, dc) = movements[currentMovement]

		r += dr
		c += dc
	}

	return spiral
}

/// Rotate image
///
/// You are given an `n x n` 2D `matrix` representing an image, rotate the image
/// by **90** degrees (clockwise).
///
/// You have to rotate the image **in-place**, which means you have to modify
/// the input 2D matrix directly. **DO NOT** allocate another 2D matrix and do
/// the rotation.
func rotate(_ matrix: inout [[Int]]) {
	let n = matrix.count

	for i in 0 ..< n / 2 {
		let k = n - 1 - i
		for j in i ..< k {
			let l = n - 1 - j
			let tmp = matrix[i][j]
			// top left
			matrix[i][j] = matrix[l][i]
			// bottom left
			matrix[l][i] = matrix[k][l]
			// bottom right
			matrix[k][l] = matrix[j][k]
			// top right
			matrix[j][k] = tmp
		}
	}
}

/// Set matrix zeroes
///
/// Given an `m x n` integer matrix matrix, if an element is `0`, set its entire
/// row and column to `0`'s.
///
/// You must do it in place.
func setZeroes(_ matrix: inout [[Int]]) {
	let (m, n) = (matrix.count, matrix[0].count)
	var clearFirstRow = false, clearFirstColumn = false

	for n in matrix[0] where n == 0 {
		clearFirstRow = true
		break
	}

	for i in 0..<m where matrix[i][0] == 0 {
		clearFirstColumn = true
		break
	}

	for i in 1..<m {
		for j in 1..<n where matrix[i][j] == 0 {
			matrix[i][0] = 0
			matrix[0][j] = 0
		}
	}

	for i in 1..<m {
		for j in 1..<n where matrix[i][0] == 0 || matrix[0][j] == 0 {
			matrix[i][j] = 0
		}
	}

	if clearFirstRow {
		for j in 0..<n {
			matrix[0][j] = 0
		}
	}

	if clearFirstColumn {
		for i in 0..<m {
			matrix[i][0] = 0
		}
	}
}

/// Game of life
///
/// According to Wikipedia's article: "The **Game of Life**, also known simply
/// as **Life**, is a cellular automaton devised by the British mathematician
/// John Horton Conway in 1970."
///
/// The board is made up of an `m x n` grid of cells, where each cell has an
/// initial state: `live` (represented by a `1`) or `dead` (represented by a
/// `0`). Each cell interacts with its eight neighbors (horizontal, vertical,
/// diagonal) using the following four rules (taken from the above Wikipedia
/// article):
///
/// 1. Any live cell with fewer than two live neighbors dies as if caused by
///    under-population.
/// 1. Any live cell with two or three live neighbors lives on to the next
///    generation.
/// 1. Any live cell with more than three live neighbors dies, as if by
///    over-population.
/// 1. Any dead cell with exactly three live neighbors becomes a live cell, as
///    if by reproduction.
///
/// The next state is created by applying the above rules simultaneously to
/// every cell in the current state, where births and deaths occur
/// simultaneously. Given the current state of the `m x n` grid `board`, return
/// *the next state*.
func gameOfLife(_ board: inout [[Int]]) {

}
