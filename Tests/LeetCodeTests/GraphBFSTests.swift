import Testing
@testable import LeetCode

@Suite("Graph BFS")
struct LeetCodeSwiftTests {
	@Test("Snakes and ladders", arguments: [
		TestCase(
			given: [
				[-1, -1, -1, -1, -1, -1],
				[-1, -1, -1, -1, -1, -1],
				[-1, -1, -1, -1, -1, -1],
				[-1, 35, -1, -1, 13, -1],
				[-1, -1, -1, -1, -1, -1],
				[-1, 15, -1, -1, -1, -1]
			],
			expected: 4
		),
		TestCase(given: [[-1, -1], [-1, 3]], expected: 1),
		TestCase(
			given: [
				[ 1, -1, -1],
				[ 1,  1,  1],
				[-1,  1,  1]
			],
			expected: -1
		),
		TestCase(
			given: [
				[-1, -1, -1, -1, 48,  5, -1],
				[12, 29, 13,  9, -1,  2, 32],
				[-1, -1, 21,  7, -1, 12, 49],
				[42, 37, 21, 40, -1, 22, 12],
				[42, -1,  2, -1, -1, -1,  6],
				[39, -1, 35, -1, -1, 39, -1],
				[-1, 36, -1, -1, -1, -1,  5]
			],
			expected: 3
		),
		TestCase(
			given: [
				[-1, 1, 1, 1],
				[-1, 7, 1, 1],
				[ 1, 1, 1, 1],
				[-1, 1, 9, 1]
			],
			expected: -1
		),
	])
	func testSnakesAndLadders(c: TestCase<[[Int]], Int>) throws {
		let (board, expected) = (c.given, c.expected)

		let n = board.count
		try #require(board.allSatisfy { $0.count == n })
		try #require(2 <= n && n <= 20)
		try #require(board.allSatisfy { row in
			row.allSatisfy { cell in
				cell == -1 || (1...(n * n)).contains(cell)
			}
		})

		#expect(snakesAndLadders(board) == expected)
	}

	@Test("Minimum genetic mutation", arguments: [
		TestCase(
			given: Pair(
				Pair("AACCGGTT", "AACCGGTA"),
				["AACCGGTA"]
			),
			expected: 1
		),
		TestCase(
			given: Pair(
				Pair("AACCGGTT", "AAACGGTA"),
				["AACCGGTA", "AACCGCTA", "AAACGGTA"]
			),
			expected: 1
		),
	])
	func testMinMutation(
		c: TestCase<Pair<Pair<String, String>, [String]>, Int>
	) throws {
		let (genesAndBank, expected) = (c.given, c.expected)
		let (genes, bank) = genesAndBank.values
		let (startGene, endGene) = genes.values

		try #require(bank.count <= 10)
		try #require(startGene.count == endGene.count && startGene.count == 8)
		try #require(bank.allSatisfy { $0.count == 8 })
		try #require(([startGene, endGene] + bank).allSatisfy {
			$0.allSatisfy {
				(["A", "C", "G", "T"] as Set).contains($0)
			}
		})

		#expect(minMutation(startGene, endGene, bank) == expected)
	}
}
