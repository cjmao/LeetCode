import Testing
@testable import LeetCode

@Suite("Graph General")
struct GraphGeneralTests {
	@Test("Number of islands", arguments: [
		TestCase(
			given: [
				["1", "1", "1", "1", "0"],
				["1", "1", "0", "1", "0"],
				["1", "1", "0", "0", "0"],
				["0", "0", "0", "0", "0"]
			],
			expected: 1
		),
		TestCase(
			given: [
				["1", "1", "0", "0", "0"],
				["1", "1", "0", "0", "0"],
				["0", "0", "1", "0", "0"],
				["0", "0", "0", "1", "1"]
			],
			expected: 3
		),
		TestCase(
			given: [
				["1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "0", "1", "0", "1", "1"],
				["0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "0"],
				["1", "0", "1", "1", "1", "0", "0", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "0", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "0", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "0", "1", "1", "1", "0", "1", "1", "1"],
				["0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "0", "1", "1", "1", "1"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "0", "1", "1"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["0", "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1"],
				["1", "0", "1", "1", "1", "1", "1", "0", "1", "1", "1", "0", "1", "1", "1", "1", "0", "1", "1", "1"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "0"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "0", "0"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
				["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"]
			],
			expected: 1
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

	@Test("Surrounded regions", arguments: [
		TestCase(
			given: [
				["X", "X", "X", "X"],
				["X", "O", "O", "X"],
				["X", "X", "O", "X"],
				["X", "O", "X", "X"]
			],
			expected: [
				["X", "X", "X", "X"],
				["X", "X", "X", "X"],
				["X", "X", "X", "X"],
				["X", "O", "X", "X"]
			]
		),
		TestCase(given: [["X"]], expected: [["X"]]),
		TestCase(
			given: [
				["O", "O", "O", "O", "X", "X"],
				["O", "O", "O", "O", "O", "O"],
				["O", "X", "O", "X", "O", "O"],
				["O", "X", "O", "O", "X", "O"],
				["O", "X", "O", "X", "O", "O"],
				["O", "X", "O", "O", "O", "O"]
			],
			expected: [
				["O", "O", "O", "O", "X", "X"],
				["O", "O", "O", "O", "O", "O"],
				["O", "X", "O", "X", "O", "O"],
				["O", "X", "O", "O", "X", "O"],
				["O", "X", "O", "X", "O", "O"],
				["O", "X", "O", "O", "O", "O"]
			]
		),
		TestCase(
			given: [
				["O", "X", "O", "O", "O", "X"],
				["O", "O", "X", "X", "X", "O"],
				["X", "X", "X", "X", "X", "O"],
				["O", "O", "O", "O", "X", "X"],
				["X", "X", "O", "O", "X", "O"],
				["O", "O", "X", "X", "X", "X"]
			],
			expected: [
				["O", "X", "O", "O", "O", "X"],
				["O", "O", "X", "X", "X", "O"],
				["X", "X", "X", "X", "X", "O"],
				["O", "O", "O", "O", "X", "X"],
				["X", "X", "O", "O", "X", "O"],
				["O", "O", "X", "X", "X", "X"]
			]
		),
	])
	func testSolve(c: TestCase<[[String]], [[String]]>) throws {
		var (board, expected) = (c.given.map { $0.map(Character.init) }, c.expected)

		let m = board.count
		try #require(1 <= m && m <= 200)
		let n = board[0].count
		try #require(1 <= n && n <= 200)
		try #require(board.allSatisfy { row in
			row.allSatisfy { cell in
				cell == "O" || cell == "X"
			}
		})

		solve(&board)
		#expect(board == expected.map { $0.map(Character.init) })
	}

	@Test("Clone graph", arguments: [
		TestCase(
			given: [[2, 4], [1, 3], [2, 4], [1, 3]],
			expected: [[2, 4], [1, 3], [2, 4], [1, 3]]
		),
		TestCase(given: [[]], expected: [[]]),
		TestCase(given: [], expected: []),
	])
	func testCloneGraph(c: TestCase<[[Int]], [[Int]]>) throws {
		let (adjList, expected) = (c.given, c.expected)

		try #require(adjList.count == expected.count)

		guard !expected.isEmpty else {
			let graph = GraphNode(adjList)
			let cloned = cloneGraph(graph)
			#expect(graph == nil)
			#expect(cloned == nil)
			return
		}

		let graph = try #require(GraphNode(adjList))
		let expectedGraph = try #require(GraphNode(expected))
		let nodes = graph.breadthFirstTraversal().flatMap(\.self)

		try #require(nodes.count <= 100)
		try #require(nodes.allSatisfy { 1 <= $0.val && $0.val <= 100 })
		try #require(Set(nodes.map(\.val)).count == nodes.count)

		let cloned = cloneGraph(graph)
		_ = try #require(cloned)

		for (a, b) in zip(
			cloned!.breadthFirstTraversal().flatMap(\.self),
			expectedGraph.breadthFirstTraversal().flatMap(\.self)
		) {
			#expect(a !== b)
			#expect(a.val == b.val)
			#expect(a.neighbours.map(\.val) == b.neighbours.map(\.val))
		}
	}
}
