import Testing
@testable import LeetCode

@Suite("Trie")
struct TrieTests {
	@Test("Implement trie (prefix tree)", arguments: [
		TestCase(
			given: Pair(
				[
					.initialize,
					.insert, .search, .search,
					.startsWith, .insert, .search,
				] as [TrieOperation],
				[
					nil,
					"apple", "apple", "app",
					"app", "app", "app",
				]
			),
			expected: [
				nil,
				nil, true, false,
				true, nil, true,
			]
		),
		TestCase(
			given: Pair(
				[.initialize, .startsWith],
				[nil, "a"]
			),
			expected: [nil, false]
		),
	])
	func testTrieImplementation(
		c: TestCase<Pair<[TrieOperation], [String?]>, [Bool?]>
	) throws {
		let (given, expected) = (c.given.values, c.expected)
		let operations = zip(given.0, given.1)

		func isValidWord(_ word: String) -> Bool {
			1 <= word.count && word.count <= 2000
			&& word.allSatisfy { $0.isLetter && $0.isLowercase }
		}

		var trie: Trie?

		for ((operation, argument), expected) in zip(operations, expected) {
			switch operation {
				case .initialize:
					try #require(argument == nil && expected == nil)
					trie = Trie()
				case .insert:
					try #require(expected == nil)
					let word = try #require(argument)
					try #require(isValidWord(word))
					trie?.insert(word)
				case .search:
					let word = try #require(argument)
					let expected = try #require(expected as Bool?)

					try #require(isValidWord(word))
					#expect(trie?.search(word) == expected)
				case .startsWith:
					let word = try #require(argument)
					let expected = try #require(expected as Bool?)

					try #require(isValidWord(word))
					#expect(trie?.startsWith(word) == expected)
			}
		}
	}

	@Test("Design add and search words data structure", arguments: [
		TestCase(
			given: Pair(
				[
					.initialize, .addWord, .addWord, .addWord,
					.search, .search, .search, .search,
				] as [WordDictionaryOperation],
				[
					nil, "bad", "dad", "mad",
					"pad", "bad", ".ad", "b..",
				]
			),
			expected: [
				nil, nil, nil, nil,
				false, true, true, true,
			]
		),
		TestCase(
			given: Pair(
				[
					.initialize, .addWord, .addWord,
					.search, .search, .search,
					.search, .search, .search,
				],
				[
					nil, "a", "a",
					".", "a", "aa",
					"a", ".a", "a.",
				]
			),
			expected: [
				nil, nil, nil,
				true, true, false,
				true, false, false,
			]
		),
		TestCase(
			given: Pair(
				[
					.initialize,
					.addWord, .addWord, .addWord, .addWord,
					.search, .search,
					.addWord,
					.search, .search, .search,
					.search, .search, .search,
				],
				[
					nil,
					"at", "and", "an", "add",
					"a", ".at",
					"bat",
					".at", "an.", "a.d.",
					"b.", "a.d", ".",
				]
			),
			expected: [
				nil,
				nil, nil, nil, nil,
				false, false,
				nil,
				true, true, false,
				false, true, false,
			]
		),
	])
	func testWordDictionary(
		c: TestCase<Pair<[WordDictionaryOperation], [String?]>, [Bool?]>
	) throws {
		let (given, expected) = (c.given.values, c.expected)
		let operations = zip(given.0, given.1)

		var dictionary: WordDictionary?

		for ((operation, argument), expected) in zip(operations, expected) {
			switch operation {
				case .initialize:
					try #require(argument == nil && expected == nil)
					dictionary = WordDictionary()
				case .addWord:
					try #require(expected == nil)
					let word = try #require(argument)
					try #require(
						1 <= word.count && word.count <= 25
						&& word.allSatisfy { $0.isLetter && $0.isLowercase }
					)
					dictionary?.addWord(word)
				case .search:
					let word = try #require(argument)
					let expected = try #require(expected as Bool?)

					try #require(
						1 <= word.count && word.count <= 25
						&& word.allSatisfy { $0 == "." || $0.isLetter && $0.isLowercase }
						&& word.count(where: { $0 == "." }) <= 2
					)
					#expect(dictionary?.search(word) == expected)
			}
		}
	}

	@Test("Word search II", arguments: [
		TestCase(
			given: Pair([
				["o", "a", "a", "n"],
				["e", "t", "a", "e"],
				["i", "h", "k", "r"],
				["i", "f", "l", "v"],
			], ["oath", "pea", "eat", "rain"]),
			expected: ["eat", "oath"]
		),
		TestCase(
			given: Pair([
				["a", "b"],
				["c", "d"],
			], ["abcb"]),
			expected: []
		),
	])
	func testFindWords(c: TestCase<Pair<[[String]], [String]>, [String]>) throws {
		let ((board, words), expected) = (c.given.values, c.expected)

		let (m, n) = (board.count, board[0].count)
		try #require([m, n].allSatisfy { 1 <= $0 && $0 <= 12 })
		try #require(board.allSatisfy {
			$0.allSatisfy {
				$0.count == 1 && $0.allSatisfy {
					$0.isLetter && $0.isLowercase
				}
			}
		})
		try #require(!words.isEmpty && words.allSatisfy {
			!$0.isEmpty && $0.allSatisfy {
				$0.isLetter && $0.isLowercase
			}
		})
		try #require(Set(words).count == words.count)

		#expect(findWords(board.map { $0.map(Character.init) }, words) == expected)
	}
}

enum TrieOperation: Encodable {
	case initialize
	case insert
	case search
	case startsWith
}

enum WordDictionaryOperation: Encodable {
	case initialize
	case addWord
	case search
}
