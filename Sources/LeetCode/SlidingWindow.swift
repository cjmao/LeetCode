/// Minimum size subarray sum
///
/// Given an array of positive integers `nums` and a positive integer `target`,
/// return _the **minimal length** of a subarray whose sum is greater than or
/// equal to `target`_. If there is no such subarray, return `0` instead.
func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
	var minCount = nums.count + 1
	var sum = 0
	var i = 0

	for (j, n) in nums.enumerated() {
		sum += n

		while sum >= target {
			minCount = min(j - i + 1, minCount)
			sum -= nums[i]
			i += 1
		}
	}

	return minCount > nums.count ? 0 : minCount
}

/// Longest substring without repeating characters
///
/// Given a string `s`, find the length of the **longest** substring without
/// repeating characters.
func lengthOfLongestSubstring(_ s: String) -> Int {
	0
}

/// Substring with concatenation of all words
///
/// You are given a string `s` and an array of strings `words`. All the strings
/// of `words` are of **the same length**.
///
/// A **concatenated string** is a string that exactly contains all the strings
/// of any permutation of `words` concatenated.
///
/// - For example, if `words = ["ab","cd","ef"]`, then `"abcdef"`, `"abefcd"`,
///   `"cdabef"`, `"cdefab"`, `"efabcd"`, and `"efcdab"` are all concatenated
///   strings. `"acdbef"` is not a concatenated string because it is not the
///   concatenation of any permutation of `words`.
///
/// Return an array of *the starting indices of all the concatenated substrings in
/// `s`*. You can return the answer in **any order**.
func findSubstring(_ s: String, _ words: [String]) -> [Int] {
	[]
}
