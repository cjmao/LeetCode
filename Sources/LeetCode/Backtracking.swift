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
	[]
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
	[]
}
