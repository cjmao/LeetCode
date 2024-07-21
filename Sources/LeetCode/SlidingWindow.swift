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
	var maxLength = 0
	var i = s.startIndex
	var substringCharacters = Set<Character>()

	for j in s.indices {
		let c = s[j]
		if substringCharacters.contains(c) {
			while s[i] != c {
				substringCharacters.remove(s[i])
				i = s.index(after: i)
			}
			i = s.index(after: i)
		}
		substringCharacters.insert(c)
		let length = 1 + s.distance(from: i, to: j)
		maxLength = max(length, maxLength)
	}

	return maxLength == 0 ? s.count : maxLength
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
/// Return an array of *the starting indices of all the concatenated substrings
/// in `s`*. You can return the answer in **any order**.
func findSubstring(_ s: String, _ words: [String]) -> [Int] {
	var indices = [Int]()

	let characters = Array(s)
	let wordWidth = words.first!.count
	let substringLength = words.count * wordWidth
	let expectedCounts = words.reduce(into: [:]) { frequencies, word in
		frequencies[word] = 1 + (frequencies[word] ?? 0)
	}

	func word(at index: Int) -> String? {
		if index < 0 || index + wordWidth > characters.endIndex {
			nil
		} else {
			String(characters[index ..< index + wordWidth])
		}
	}

	for offset in 0..<wordWidth {
		var wordCounts = [String: Int]()
		var startOfSubstring = offset

		for i in stride(from: offset, to: characters.endIndex, by: wordWidth) {
			// if no more words available
			guard let currentWord = word(at: i) else { break }

			// if current word is not in the given list of words
			if expectedCounts[currentWord] == nil {
				wordCounts = [:]
				startOfSubstring = i + wordWidth
				continue
			}

			// if there are enough words in substring
			if i == startOfSubstring + substringLength {
				let firstWord = word(at: startOfSubstring)!
				wordCounts[firstWord]! -= 1
				startOfSubstring += wordWidth
			}

			// count current word
			wordCounts[currentWord, default: 0] += 1

			// check if the substring is a permutation of given words
			if wordCounts == expectedCounts {
				indices.append(startOfSubstring)
			}
		}
	}

	return indices
}
