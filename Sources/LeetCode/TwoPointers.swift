/// Valid palindrome
///
/// A phrase is a **palindrome** if, after converting all uppercase letters into
/// lowercase letters and removing all non-alphanumeric characters, it reads the
/// same forward and backward. Alphanumeric characters include letters and
/// numbers.
///
/// Given a string `s`, return *`true` if it is a **palindrome**, or `false`
/// otherwise*.
func isPalindrome(_ s: String) -> Bool {
	var i = s.startIndex, j = s.index(before: s.endIndex)

	while i < j {
		let (a, b) = (s[i], s[j])
		if a.isAlphanumeric, b.isAlphanumeric,
		   a.lowercased() != b.lowercased() {
			return false
		}

		if a.isAlphanumeric, !b.isAlphanumeric {
			j = s.index(before: j)
		} else if !a.isAlphanumeric, b.isAlphanumeric {
			i = s.index(after: i)
		} else {
			i = s.index(after: i)
			j = s.index(before: j)
		}
	}

	return true
}

/// Is subsequence
///
/// Given two strings `s` and `t`, return *`true` if `s` is a subsequence of
/// `t`, or `false` otherwise*.
///
/// A **subsequence** of a string is a new string that is formed from the
/// original string by deleting some (can be none) of the characters without
/// disturbing the relative positions of the remaining characters. (i.e.,
/// `"ace"` is a subsequence of `"abcde"` while `"aec"` is not).
func isSubsequence(_ s: String, _ t: String) -> Bool {
	var i = s.startIndex, j = t.startIndex

	while i < s.endIndex, j < t.endIndex {
		let (a, b) = (s[i], t[j])

		if a == b {
			i = s.index(after: i)
		}

		j = t.index(after: j)
	}

	return i == s.endIndex
}

extension Character {
	var isAlphanumeric: Bool {
		isLetter || isNumber
	}
}
