/// Ransom note
///
/// Given two strings `ransomNote` and `magazine`, return *`true` if
/// `ransomNote` can be constructed by using the letters from `magazine` and
/// `false` otherwise*.
///
/// Each letter in `magazine` can only be used once in `ransomNote`.
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
	var counts = ransomNote.reduce(into: [:]) { partialResult, character in
		partialResult[character, default: 0] += 1
	}
	counts = magazine.reduce(into: counts) { partialResult, character in
		if let count = partialResult[character] {
			if count == 1 {
				partialResult.removeValue(forKey: character)
			} else {
				partialResult[character] = count - 1
			}
		}
	}
	return counts.isEmpty
}

/// Isomorphic strings
///
/// Given two strings `s` and `t`, *determine if they are isomorphic*.
///
/// Two strings `s` and `t` are isomorphic if the characters in `s` can be
/// replaced to get `t`.
///
/// All occurrences of a character must be replaced with another character while
/// preserving the order of characters. No two characters may map to the same
/// character, but a character may map to itself.
func isIsomorphic(_ s: String, _ t: String) -> Bool {
	var map = [Character: Character]()
	var used = Set<Character>()

	for (c1, c2) in zip(s, t) {
		let mapOfC1 = map[c1]
		let c1Used = mapOfC1 != nil
		let c2Used = used.contains(c2)
		if (c1Used || c2Used) && mapOfC1 != c2 {
			return false
		}
		map[c1] = c2
		used.insert(c2)
	}

	return true
}

/// Word pattern
///
/// Given a `pattern` and a string `s`, find if `s` follows the same pattern.
///
/// Here **follow** means a full match, such that there is a bijection between a
/// letter in `pattern` and a **non-empty** word in `s`.
func wordPattern(_ pattern: String, _ s: String) -> Bool {
	var words = [Character: Substring]()
	var used = Set<Substring>()
	var i = s.startIndex, j = s.startIndex

	for p in pattern {
		while j < s.endIndex, s[j] != " " {
			j = s.index(after: j)
		}

		let word = s[i..<j]

		if (words[p] != nil || used.contains(word)), words[p] != word {
			return false
		}

		words[p] = word
		used.insert(word)

		if j < s.endIndex {
			j = s.index(after: j)
			i = j
		}
	}

	return j == s.endIndex
}

/// Valid anagram
///
/// Given two strings `s` and `t`, return *`true` if `t` is an anagram of `s`,
/// and `false` otherwise*.
///
/// An **Anagram** is a word or phrase formed by rearranging the letters of a
/// different word or phrase, typically using all the original letters exactly
/// once.
func isAnagram(_ s: String, _ t: String) -> Bool {
	var counts = s.reduce(into: [:]) { result, c in
		result[c, default: 0] += 1
	}

	for c in t {
		guard let count = counts[c], count > 0 else {
			return false
		}
		if count == 1 {
			counts.removeValue(forKey: c)
		} else {
			counts[c] = count - 1
		}
	}

	return counts.isEmpty
}

/// Group anagrams
///
/// Given an array of strings `strs`, group **the anagrams** together. You can
/// return the answer in **any order**.
///
/// An **Anagram** is a word or phrase formed by rearranging the letters of a
/// different word or phrase, typically using all the original letters exactly
/// once.
func groupAnagrams(_ strs: [String]) -> [[String]] {
	var groups = [Int: [String]]()

	for s in strs {
		let key = s.sorted().hashValue
		groups[key, default: []].append(s)
	}

	return groups.map { $0.value }
}

/// Two sum
///
/// Given an array of integers `nums` and an integer `target`, return *indices
/// of the two numbers such that they add up to `target`*.
///
/// You may assume that each input would have `exactly one solution`, and you
/// may not use the same element twice.
///
/// You can return the answer in any order.
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
	var indices = [Int: Int]()

	for (i, num) in nums.enumerated() {
		let target = target - num
		if let j = indices[target] {
			return [j, i]
		}
		indices[num] = i
	}

	return []
}

/// Happy number
///
/// Write an algorithm to determine if a number `n` is happy.
///
/// A **happy number** is a number defined by the following process:
///
/// - Starting with any positive integer, replace the number by the sum of the
///   squares of its digits.
/// - Repeat the process until the number equals 1 (where it will stay), or it
///   **loops endlessly in a cycle** which does not include 1.
/// - Those numbers for which this process **ends in 1** are happy.
///
/// Return *`true` if `n` is a happy number, and `false` if not*.
func isHappy(_ n: Int) -> Bool {
	false
}

/// Contains duplicate II
///
/// Given an integer array `nums` and an integer `k`, return _`true` if there
/// are two **distinct indices** `i` and `j` in the array such that
/// `nums[i] == nums[j]` and `abs(i - j) <= k`_.
func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
	false
}
