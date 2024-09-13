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
	private class Node {
		var isWord = false
		var children: [Character: Node] = [:]
	}

	private let root = Node()

	func addWord(_ word: String) {
		var current = root
		for c in word {
			let next = current.children[c, default: .init()]
			current.children[c] = next
			current = next
		}
		current.isWord = true
	}

	func search(_ word: String) -> Bool {
		search(word, from: root)
	}

	private func search(_ word: some StringProtocol, from node: Node) -> Bool {
		let head = word.first!
		let indexAfter = word.index(after: word.startIndex)
		let tail = word[indexAfter...]

		if head != "." {
			return if let next = node.children[head] {
				tail.isEmpty ? next.isWord : search(tail, from: next)
			} else {
				false
			}
		}

		let match = node.children.first { _, next in
			tail.isEmpty ? next.isWord : search(tail, from: next)
		}

		return match != nil
	}
}

/// Word search II
///
/// Given an `m x n` board of characters and a list of strings `words`, return
/// _all words on the board_.
///
/// Each word must be constructed from letters of sequentially adjacent cells,
/// where **adjacent cells** are horizontally or vertically neighboring. The
/// same letter cell may not be used more than once in a word.
func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
	let trie = TrieNode()
	for word in words {
		trie.insert(word)
	}

	let (m, n) = (board.count, board[0].count)

	var wordsFound = [String]()
	var visited = Set<Int>()

	func search(node: TrieNode, row: Int, column: Int) {
		guard 0 <= row, row < m, 0 <= column, column < n else {
			return
		}

		let index = row * n + column
		let letter = board[row][column]

		guard !visited.contains(index), let next = node.children[letter] else {
			return
		}

		visited.insert(index)

		if let word = next.word {
			wordsFound.append(word)
			next.word = nil
		}

		for (r, c) in [
			(row - 1, column), (row + 1, column),
			(row, column - 1), (row, column + 1)
		] {
			search(node: next, row: r, column: c)
		}

		visited.remove(index)

		if next.children.isEmpty {
			node.children.removeValue(forKey: letter)
		}
	}

	for i in 0 ..< m * n {
		let (r, c) = i.quotientAndRemainder(dividingBy: n)
		search(node: trie, row: r, column: c)
		visited.removeAll()
	}

	return wordsFound
}

private class TrieNode {
	var word: String?
	var children: [Character: TrieNode] = [:]

	func insert(_ word: String) {
		var current = self

		for c in word {
			let next = current.children[c, default: .init()]
			current.children[c] = next
			current = next
		}

		current.word = word
	}
}
