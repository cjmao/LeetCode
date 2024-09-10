/// Implement trie (prefix tree)
///
/// A **trie** (pronounced as "try") or **prefix tree** is a tree data structure
/// used to efficiently store and retrieve keys in a dataset of strings. There
/// are various applications of this data structure, such as autocomplete and
/// spellchecker.
///
/// Implement the Trie class:
///
/// - `Trie()` Initializes the trie object.
/// - `void insert(String word)` Inserts the string `word` into the trie.
/// - `boolean search(String word)` Returns `true` if the string `word` is in
///   the trie (i.e., was inserted before), and `false` otherwise.
/// - `boolean startsWith(String prefix)` Returns `true` if there is a
///   previously inserted string `word` that has the prefix `prefix`, and
///   `false` otherwise.
class Trie {
	private class Node {
		var isWord = false
		var children: [Character: Node] = [:]
	}

	private let root = Node()

	func insert(_ word: String) {
		var current = root

		for c in word {
			let next = current.children[c, default: .init()]
			current.children[c] = next
			current = next
		}

		current.isWord = true
	}

	func search(_ word: String) -> Bool {
		traverse(path: word)?.isWord ?? false
	}

	func startsWith(_ prefix: String) -> Bool {
		traverse(path: prefix) != nil
	}

	private func traverse(path: String) -> Node? {
		var node: _? = root

		for c in path where node != nil {
			node = node?.children[c]
		}

		return node
	}
}

/// Design add and search words data structure
///
/// Design a data structure that supports adding new words and finding if a
/// string matches any previously added string.
///
/// Implement the `WordDictionary` class:
///
/// - `WordDictionary()` Initializes the object.
/// - `void addWord(word)` Adds `word` to the data structure, it can be matched later.
/// - `bool search(word)` Returns `true` if there is any string in the data
///   structure that matches `word` or `false` otherwise. `word` may contain
///   dots '.' where dots can be matched with any letter.
class WordDictionary {
	init() {

	}

	func addWord(_ word: String) {

	}

	func search(_ word: String) -> Bool {
		false
	}
}
