/// Number of islands
///
/// Given an `m x n` 2D binary grid `grid` which represents a map of `'1'`s
/// (land) and `'0'`s (water), return _the number of islands_.
///
/// An **island** is surrounded by water and is formed by connecting adjacent
/// lands horizontally or vertically. You may assume all four edges of the grid
/// are all surrounded by water.
func numIslands(_ grid: [[Character]]) -> Int {
	let m = grid.count, n = grid[0].count

	var count = 0
	var visited = Set<Int>()

	func explore(_ i: Int, _ j: Int) {
		let c = i * n + j

		guard
			0 <= i, i < m, 0 <= j, j < n,
			grid[i][j] == "1", !visited.contains(c)
		else {
			return
		}

		visited.insert(c)

		[
			(i - 1, j), (i + 1, j),
			(i, j - 1), (i, j + 1)
		].forEach(explore)
	}

	for i in grid.indices {
		for j in grid[i].indices
		where grid[i][j] == "1" && !visited.contains(i * n + j) {
			count += 1
			explore(i, j)
		}
	}

	return count
}

/// Surrounded regions
///
/// You are given an `m x n` matrix `board` containing letters `'X'` and `'O'`,
/// **capture regions** that are **surrounded**:
///
/// - **Connect**: A cell is connected to adjacent cells horizontally or
///   vertically.
/// - **Region**: To form a region **connect every** `'O'` cell.
/// - **Surround**: The region is surrounded with `'X'` cells if you can
///   **connect the region** with `'X'` cells and none of the region cells are
///   on the edge of the `board`.
///
/// A **surrounded region is captured** by replacing all `'O'`s with `'X'`s in
/// the input matrix `board`.
func solve(_ board: inout [[Character]]) {
	let m = board.count, n = board[0].count

	func formRegion(_ i: Int, _ j: Int) {
		guard 0 <= i, i < m, 0 <= j, j < n, board[i][j] == "O" else {
			return
		}

		board[i][j] = "."

		[
			(i - 1, j), (i + 1, j),
			(i, j - 1), (i, j + 1)
		].forEach(formRegion)
	}

	for i in [0, m - 1] {
		for j in board[i].indices where board[i][j] == "O" {
			formRegion(i, j)
		}
	}

	for j in [0, n - 1] {
		for i in board.indices where board[i][j] == "O" {
			formRegion(i, j)
		}
	}

	for i in 0..<m {
		for j in 0..<n {
			board[i][j] = board[i][j] == "." ? "O" : "X"
		}
	}
}
