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

}
