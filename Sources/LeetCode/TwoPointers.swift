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

/// Two sum II - input array is sorted
///
/// Given a **1-indexed** array of integers `numbers` that is already
/// _**sorted in non-decreasing order**_, find two numbers such that they add up
/// to a specific `target` number. Let these two numbers be `numbers[index1]`
/// and `numbers[index2]` where `1 <= index1 < index2 <= numbers.length`.
///
/// Return _the indices of the two numbers, `index1` and `index2`, **added by
/// one** as an integer array `[index1, index2]` of length 2_.
///
/// The tests are generated such that there is **exactly one solution**. You
/// **may not** use the same element twice.
///
/// Your solution must use only constant extra space.
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
	var i = 0, j = numbers.endIndex - 1

	while i < j - 1, numbers[i] + numbers[j] != target {
		while j > 1, numbers[i] + numbers[j] > target {
			j -= 1
		}
		while i < j - 1, numbers[i] + numbers[j] < target {
			i += 1
		}
	}

	return [i + 1, j + 1]
}

/// Container with most water
///
/// You are given an integer array `height` of length `n`. There are `n`
/// vertical lines drawn such that the two endpoints of the `ith` line are
/// `(i, 0)` and `(i, height[i])`.
///
/// Find two lines that together with the x-axis form a container, such that the
/// container contains the most water.
///
/// Return *the maximum amount of water a container can store*.
///
/// **Notice** that you may not slant the container.
func maxArea(_ height: [Int]) -> Int {
	var maxArea = 0
	var area = 0

	var i = height.startIndex, j = height.endIndex - 1

	while i < j {
		let (a, b) = (height[i], height[j])
		area = (j - i) * min(a, b)
		maxArea = max(area, maxArea)

		if a < b {
			i += 1
		} else {
			j -= 1
		}
	}

	return maxArea
}

/// 3 Sum
///
/// Given an integer array `nums`, return all the triplets
///
/// `[nums[i], nums[j], nums[k]]`
///
/// such that
/// - `i != j`
/// - `i != k`
/// - `j != k`
///
/// and
///
/// - `nums[i] + nums[j] + nums[k] == 0`.
///
/// Notice that the solution set must not contain duplicate triplets.
func threeSum(_ nums: [Int]) -> [[Int]] {
	[]
}

extension Character {
	var isAlphanumeric: Bool {
		isLetter || isNumber
	}
}
