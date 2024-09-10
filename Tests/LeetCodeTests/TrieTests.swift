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
					.search, .search, .search, .search
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
