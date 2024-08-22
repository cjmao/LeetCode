/// Snakes and ladders
///
/// You are given an `n x n` integer matrix `board` where the cells are labeled
/// from `1` to `n^2` in a **Boustrophedon style** starting from the bottom left
/// of the board (i.e. `board[n - 1][0]`) and alternating direction each row.
///
/// You start on square `1` of the board. In each move, starting from square
/// `curr`, do the following:
///
/// - Choose a destination square `next` with a label in the range
///   `[curr + 1, min(curr + 6, n^2)]`.
///   - This choice simulates the result of a standard **6-sided die roll**:
///     i.e., there are always at most 6 destinations, regardless of the size of
///     the board.
/// - If `next` has a snake or ladder, you **must** move to the destination of
///   that snake or ladder. Otherwise, you move to `next`.
/// - The game ends when you reach the square `n^2`.
///
/// A board square on row `r` and column `c` has a snake or ladder if
/// `board[r][c] != -1`. The destination of that snake or ladder is
/// `board[r][c]`. Squares `1` and `n^2` do not have a snake or ladder.
///
/// Note that you only take a snake or ladder at most once per move. If the
/// destination to a snake or ladder is the start of another snake or ladder,
/// you do **not** follow the subsequent snake or ladder.
///
/// - For example, suppose the board is `[[-1, 4], [-1, 3]]`, and on the first
///   move, your destination square is `2`. You follow the ladder to square `3`,
///   but do **not** follow the subsequent ladder to `4`.
///
/// Return _the least number of moves required to reach the square `n^2`. If it
/// is not possible to reach the square, return `-1`_.
func snakesAndLadders(_ board: [[Int]]) -> Int {
	0
}

/// Minimum genetic mutation
///
/// A gene string can be represented by an 8-character long string, with choices
/// from `'A'`, `'C'`, `'G'`, and `'T'`.
///
/// Suppose we need to investigate a mutation from a gene string `startGene` to
/// a gene string `endGene` where one mutation is defined as one single
/// character changed in the gene string.
///
/// - For example, `"AACCGGTT" --> "AACCGGTA"` is one mutation.
///
/// There is also a gene bank `bank` that records all the valid gene mutations.
/// A gene must be in `bank` to make it a valid gene string.
///
/// Given the two gene strings `startGene` and `endGene` and the gene bank
/// `bank`, return _the minimum number of mutations needed to mutate from
/// `startGene` to `endGene`_. If there is no such a mutation, return `-1`.
///
/// Note that the starting point is assumed to be valid, so it might not be
/// included in the bank.
func minMutation(_ startGene: String, _ endGene: String, _ bank: [String]) -> Int {
	0
}
