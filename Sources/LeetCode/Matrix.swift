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
	[]
}
