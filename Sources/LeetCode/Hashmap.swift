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
	false
}

/// Word pattern
///
/// Given a `pattern` and a string `s`, find if `s` follows the same pattern.
///
/// Here **follow** means a full match, such that there is a bijection between a
/// letter in `pattern` and a **non-empty** word in `s`.
func wordPattern(_ pattern: String, _ s: String) -> Bool {
	false
}
