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
	[]
}
