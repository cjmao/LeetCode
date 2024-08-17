import Testing
@testable import LeetCode

@Suite("Graph General")
struct GraphGeneralTests {
	@Test("Number of islands", arguments: [
		TestCase(
			given: [
				["1","1","1","1","0"],
				["1","1","0","1","0"],
				["1","1","0","0","0"],
				["0","0","0","0","0"]
			],
			expected: 1
		),
		TestCase(
			given: [
				["1","1","0","0","0"],
				["1","1","0","0","0"],
				["0","0","1","0","0"],
				["0","0","0","1","1"]
			],
			expected: 3
		),
	])
	func testNumIslands(c: TestCase<[[String]], Int>) throws {
		let (grid, expected) = (c.given, c.expected)

		let m = grid.count
		try #require(1 <= m && m <= 300)
		let n = grid[0].count
		try #require(1 <= n && n <= 300)
		try #require(grid.allSatisfy { row in
			row.allSatisfy { cell in
				cell == "0" || cell == "1"
			}
		})

		let map = grid.map { $0.map(Character.init) }
		#expect(numIslands(map) == expected)
	}
}
