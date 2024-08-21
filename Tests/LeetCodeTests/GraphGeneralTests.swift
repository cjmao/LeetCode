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
			#expect(a.neighbors.map(\.?.val) == b.neighbors.map(\.?.val))
		}
	}

	@Test("Evaluate division", arguments: [
		TestCase(
			given: Pair(
				[["a", "b"], ["b", "c"]],
				Pair(
					[2, 3],
					[["a", "c"], ["b", "a"], ["a", "e"], ["a", "a"], ["x", "x"]]
				)
			),
			expected: [6, 0.5, -1, 1, -1]
		),
		TestCase(
			given: Pair(
				[["a", "b"], ["b", "c"], ["bc", "cd"]],
				Pair(
					[1.5, 2.5, 5],
					[["a", "c"], ["c", "b"], ["bc", "cd"], ["cd", "bc"]]
				)
			),
			expected: [3.75, 0.4, 5, 0.2]
		),
		TestCase(
			given: Pair(
				[["a", "b"]],
				Pair(
					[0.5],
					[["a", "b"], ["b", "a"], ["a", "c"], ["x", "y"]]
				)
			),
			expected: [0.5, 2, -1, -1]
		),
	])
	func testCalcEquation(
		c: TestCase<Pair<[[String]], Pair<[Double], [[String]]>>, [Double]>
	) throws {
		let (given, expected) = (c.given, c.expected)
		let (equations, rest) = given.values
		let (values, queries) = rest.values

		try #require(1 <= equations.count && equations.count <= 20)
		try #require(1 <= queries.count && queries.count <= 20)
		try #require([equations, queries].allSatisfy { equations in
			equations.allSatisfy { equation in
				equation.count == 2 && equation.allSatisfy { variable in
					1 <= variable.count && variable.count <= 5
					&& Array(variable).allSatisfy { c in
						c.isWholeNumber || c.isLetter && c.isLowercase
					}
				}
			}
		})
		try #require(values.count == equations.count)
		try #require(values.allSatisfy { 0 < $0 && $0 <= 20 })

		let result = calcEquation(equations, values, queries)
		#expect(result == expected)
	}

	@Test("Course schedule", arguments: [
		TestCase(given: Pair(2, [[1, 0]]), expected: true),
		TestCase(given: Pair(2, [[1, 0], [0, 1]]), expected: false),
		TestCase(
			given: Pair(7, [
				[1, 0], [0, 3], [0, 2], [3, 2], [2, 5], [4, 5], [5, 6], [2, 4]
			]),
			expected: true
		),
	])
	func testCanFinish(c: TestCase<Pair<Int, [[Int]]>, Bool>) throws {
		let ((numCourses, prerequisites), expected) = (c.given.values, c.expected)

		try #require(1 <= numCourses && numCourses <= 2000)
		try #require(prerequisites.count <= 5000)
		try #require(prerequisites.allSatisfy {
			$0.count == 2 && $0.allSatisfy {
				0 <= $0 && $0 < numCourses
			}
		})
		try #require(Set(prerequisites).count == prerequisites.count)

		#expect(canFinish(numCourses, prerequisites) == expected)
	}

	@Test("Course schedule II", arguments: [
		TestCase(given: Pair(2, [[1, 0]]), expected: [0, 1]),
		TestCase(
			given: Pair(4, [[1, 0], [2, 0], [3, 1], [3, 2]]),
			expected: [0, 2, 1, 3]
		),
		TestCase(given: Pair(1, []), expected: [0]),
	])
	func testFindOrder(c: TestCase<Pair<Int, [[Int]]>, [Int]>) throws {
		let ((numCourses, prerequisites), expected) = (c.given.values, c.expected)

		try #require(1 <= numCourses && numCourses <= 2000)
		try #require(prerequisites.count <= numCourses * (numCourses - 1))
		try #require(prerequisites.allSatisfy {
			$0.count == 2 && $0.allSatisfy {
				0 <= $0 && $0 < numCourses
			}
		})
		try #require(Set(prerequisites).count == prerequisites.count)

		#expect(findOrder(numCourses, prerequisites) == expected)
	}

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
}
