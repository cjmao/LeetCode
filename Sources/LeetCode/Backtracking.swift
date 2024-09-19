/// Letter combinations of a phone number
///
/// Given a string containing digits from `2-9` inclusive, return all possible
/// letter combinations that the number could represent. Return the answer in
/// **any order**.
///
/// Note that 1 does not map to any letters.
func letterCombinations(_ digits: String) -> [String] {
	guard !digits.isEmpty else {
		return []
	}

	let lettersOfDigit = [
		["a", "b", "c"],
		["d", "e", "f"],
		["g", "h", "i"],
		["j", "k", "l"],
		["m", "n", "o"],
		["p", "q", "r", "s"],
		["t", "u", "v"],
		["w", "x", "y", "z"],
	]

	var combinations = [String]()

	func combine(from index: String.Index, into letters: String) {
		guard index != digits.endIndex else {
			combinations.append(letters)
			return
		}

		let digit = digits[index].wholeNumberValue!
		for letter in lettersOfDigit[digit - 2] {
			combine(from: digits.index(after: index), into: letters + letter)
		}
	}

	combine(from: digits.startIndex, into: "")

	return combinations
}

/// Combinations
///
/// Given two integers `n` and `k`, return _all possible combinations of `k`
/// numbers chosen from the range `[1, n]`_.
///
/// You may return the answer in **any order**.
func combine(_ n: Int, _ k: Int) -> [[Int]] {
	var combinations = [[Int]]()
	var combination = [Int]()

	func backtrack(from i: Int) {
		guard combination.count < k else {
			combinations.append(combination)
			return
		}

		for j in i..<(n + 1) {
			combination.append(j)
			backtrack(from: j + 1)
			combination.removeLast()
		}
	}

	backtrack(from: 1)

	return combinations
}

/// Permutations
///
/// Given an array `nums` of distinct integers, return _all the possible
/// permutations_. You can return the answer in **any order**.
func permute(_ nums: [Int]) -> [[Int]] {
	var nums = nums
	var permutations = [[Int]]()

	func backtrack(from startIndex: Int) {
		guard startIndex < nums.endIndex else {
			permutations.append(nums)
			return
		}

		for index in startIndex..<nums.endIndex {
			nums.swapAt(startIndex, index)
			backtrack(from: startIndex + 1)
			nums.swapAt(startIndex, index)
		}
	}

	backtrack(from: 0)

	return permutations
}

/// Combination sum
///
/// Given an array of **distinct** integers `candidates` and a target integer
/// `target`, return _a list of all **unique combinations** of `candidates`
/// where the chosen numbers sum to `target`_. You may return the combinations
/// in **any order**.
///
/// The **same** number may be chosen from `candidates` an **unlimited number of
/// times**. Two combinations are unique if the frequency of at least one of the
/// chosen numbers is different.
///
/// The test cases are generated such that the number of unique combinations
/// that sum up to `target` is less than `150` combinations for the given input.
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
	var combinations = [[Int]]()
	var combination = [Int]()

	func backtrack(target: Int) {
		guard target > 0 else {
			combinations.append(combination)
			return
		}

		for candidate in candidates
		where target >= candidate && candidate >= combination.last ?? .min {
			combination.append(candidate)
			backtrack(target: target - candidate)
			combination.removeLast()
		}
	}

	backtrack(target: target)

	return combinations
}

/// N-Queens II
///
/// The **n-queens** puzzle is the problem of placing `n` queens on an `n x n`
/// chessboard such that no two queens attack each other.
///
/// Given an integer `n`, return _the number of distinct solutions to the
/// **n-queens puzzle**_.
func totalNQueens(_ n: Int) -> Int {
	var count = 0

	func backtrack(
		fromRow row: Int,
		availableColumns: Int,
		usedDiagonals: Int,
		usedAntidiagonals: Int
	) {
		guard row < n else {
			count += 1
			return
		}

		var uncheckedColumns = availableColumns

		// find the right most 1-bit
		var nextAvailableColumn = uncheckedColumns & -uncheckedColumns

		while nextAvailableColumn != 0 {
			let column = nextAvailableColumn.trailingZeroBitCount

			// set the current column bit to 0
			uncheckedColumns &= ~(1 << column)
			nextAvailableColumn = uncheckedColumns & -uncheckedColumns

			let diagonal = row + column
			let antidiagonal = row + (n - column - 1) // flip column

			guard
				usedDiagonals & (1 << diagonal) == 0,
				usedAntidiagonals & (1 << antidiagonal) == 0
			else {
				continue
			}

			backtrack(
				fromRow: row + 1, // from next row
				availableColumns: availableColumns & ~(1 << column), // excluding current column
				usedDiagonals: usedDiagonals | (1 << diagonal), // including current diagonal
				usedAntidiagonals: usedAntidiagonals | (1 << antidiagonal) // including current antidiagonal
			)
		}
	}

	backtrack(
		fromRow: 0,
		availableColumns: (1 << n) - 1,
		usedDiagonals: 0,
		usedAntidiagonals: 0
	)

	return count
}

/// Generate parentheses
///
/// Given `n` pairs of parentheses, write a function to _generate all
/// combinations of well-formed parentheses_.
func generateParenthesis(_ n: Int) -> [String] {
	var parentheses = [String]()

	func backtrack(_ pairs: String, _ open: Int, _ close: Int) {
		guard pairs.count < 2 * n else {
			parentheses.append(pairs)
			return
		}

		if open < n {
			backtrack(pairs + "(", open + 1, close)
		}

		if close < open {
			backtrack(pairs + ")", open, close + 1)
		}
	}

	backtrack("(", 1, 0)

	return parentheses
}

/// Word search
///
/// Given an `m x n` grid of characters `board` and a string `word`, return
/// _`true` if `word` exists in the grid_.
///
/// The word can be constructed from letters of sequentially adjacent cells,
/// where adjacent cells are horizontally or vertically neighboring. The same
/// letter cell may not be used more than once.
func exist(_ board: [[Character]], _ word: String) -> Bool {
	false
}
