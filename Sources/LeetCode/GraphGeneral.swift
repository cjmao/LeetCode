class GraphNode: CustomDebugStringConvertible {
	let val: Int
	var neighbors: [GraphNode?]

	init(_ val: Int) {
		self.val = val
		self.neighbors = []
	}

	init?(_ adjacencyList: [[Int]]) {
		guard !adjacencyList.isEmpty else {
			return nil
		}

		let nodes = adjacencyList.indices.map { GraphNode($0 + 1) }

		for (i, neighbours) in adjacencyList.enumerated() {
			for neighbour in neighbours.sorted() {
				nodes[i].neighbors.append(nodes[neighbour - 1])
			}
		}

		self.val = nodes[0].val
		self.neighbors = nodes[0].neighbors
	}

	var debugDescription: String {
		"\(val)"
	}

	func breadthFirstTraversal() -> some Sequence<[GraphNode]> {
		var visited = [val] as Set

		return sequence(first: [self]) { previous in
			var next = [GraphNode]()

			for node in previous {
				for neighbor in node.neighbors
				where neighbor != nil && !visited.contains(neighbor!.val) {
					visited.insert(neighbor!.val)
					next.append(neighbor!)
				}
			}

			return next.isEmpty ? nil : next
		}
	}
}

/// Number of islands
///
/// Given an `m x n` 2D binary grid `grid` which represents a map of `'1'`s
/// (land) and `'0'`s (water), return _the number of islands_.
///
/// An **island** is surrounded by water and is formed by connecting adjacent
/// lands horizontally or vertically. You may assume all four edges of the grid
/// are all surrounded by water.
func numIslands(_ grid: [[Character]]) -> Int {
	let m = grid.count, n = grid[0].count

	var count = 0
	var visited = Set<Int>()

	func explore(_ i: Int, _ j: Int) {
		let c = i * n + j

		guard
			0 <= i, i < m, 0 <= j, j < n,
			grid[i][j] == "1", !visited.contains(c)
		else {
			return
		}

		visited.insert(c)

		[
			(i - 1, j), (i + 1, j),
			(i, j - 1), (i, j + 1)
		].forEach(explore)
	}

	for i in grid.indices {
		for j in grid[i].indices
		where grid[i][j] == "1" && !visited.contains(i * n + j) {
			count += 1
			explore(i, j)
		}
	}

	return count
}

/// Surrounded regions
///
/// You are given an `m x n` matrix `board` containing letters `'X'` and `'O'`,
/// **capture regions** that are **surrounded**:
///
/// - **Connect**: A cell is connected to adjacent cells horizontally or
///   vertically.
/// - **Region**: To form a region **connect every** `'O'` cell.
/// - **Surround**: The region is surrounded with `'X'` cells if you can
///   **connect the region** with `'X'` cells and none of the region cells are
///   on the edge of the `board`.
///
/// A **surrounded region is captured** by replacing all `'O'`s with `'X'`s in
/// the input matrix `board`.
func solve(_ board: inout [[Character]]) {
	let m = board.count, n = board[0].count

	func formRegion(_ i: Int, _ j: Int) {
		guard 0 <= i, i < m, 0 <= j, j < n, board[i][j] == "O" else {
			return
		}

		board[i][j] = "."

		[
			(i - 1, j), (i + 1, j),
			(i, j - 1), (i, j + 1)
		].forEach(formRegion)
	}

	for i in [0, m - 1] {
		for j in board[i].indices where board[i][j] == "O" {
			formRegion(i, j)
		}
	}

	for j in [0, n - 1] {
		for i in board.indices where board[i][j] == "O" {
			formRegion(i, j)
		}
	}

	for i in 0..<m {
		for j in 0..<n {
			board[i][j] = board[i][j] == "." ? "O" : "X"
		}
	}
}

/// Clone graph
///
/// Given a reference of a node in a **connected** undirected graph.
///
/// Return a **deep copy** (clone) of the graph.
///
/// Each node in the graph contains a value (`int`) and a list (`List[Node]`) of
/// its neighbors.
///
/// ```java
/// class Node {
/// 	public int val;
/// 	public List<Node> neighbors;
/// }
/// ```
///
/// ## Test case format:
///
/// For simplicity, each node's value is the same as the node's index
/// (1-indexed). For example, the first node with `val == 1`, the second node
/// with `val == 2`, and so on. The graph is represented in the test case using
/// an adjacency list.
///
/// **An adjacency list** is a collection of unordered **lists** used to
/// represent a finite graph. Each list describes the set of neighbors of a node
/// in the graph.
///
/// The given node will always be the first node with `val = 1`. You must return
/// the **copy of the given node** as a reference to the cloned graph.
func cloneGraph(_ node: GraphNode?) -> GraphNode? {
	guard let node = node else {
		return nil
	}

	var current = [node]
	var copies = [Int: Node]()

	while !current.isEmpty {
		var next = [Node]()

		for node in current {
			let copy = copies[node.val] ?? Node(node.val)
			copies[node.val] = copy
			guard copy.neighbors.count != node.neighbors.count else {
				continue
			}
			for neighbor in node.neighbors where neighbor != nil {
				let copyOfNeighbor = copies[neighbor!.val] ?? Node(neighbor!.val)
				copy.neighbors.append(copyOfNeighbor)
				copies[neighbor!.val] = copyOfNeighbor
				next.append(neighbor!)
			}
		}

		current = next
	}

	return copies[node.val]
}

private typealias Node = GraphNode

/// Evaluate division
///
/// You are given an array of variable pairs `equations` and an array of real
/// numbers `values`, where `equations[i] = [Ai, Bi]` and `values[i]` represent
/// the equation `Ai / Bi = values[i]`. Each `Ai` or `Bi` is a string that
/// represents a single variable.
///
/// You are also given some `queries`, where `queries[j] = [Cj, Dj]` represents
/// the `jth` query where you must find the answer for `Cj / Dj = ?`.
///
/// Return _the answers to all queries_. If a single answer cannot be
/// determined, return `-1.0`.
///
/// **Note**: The input is always valid. You may assume that evaluating the
/// queries will not result in division by zero and that there is no
/// contradiction.
///
/// **Note**: The variables that do not occur in the list of equations are
/// undefined, so the answer cannot be determined for them.
func calcEquation(
	_ equations: [[String]],
	_ values: [Double],
	_ queries: [[String]]
) -> [Double] {
	var edges = [String: [String: Double]]()

	for (i, equation) in equations.enumerated() {
		let (a, b, x) = (equation[0], equation[1], values[i])
		edges[a, default: [:]][b] = x
		edges[b, default: [:]][a] = 1 / x
	}

	var result = [Double]()

	for q in queries {
		let (start, end) = (q[0], q[1])

		guard edges[start] != nil, edges[end] != nil else {
			result.append(-1)
			continue
		}

		var weights = [1.0]
		var path = [start]
		var visited = [start] as Set

		while let v = path.last, v != end {
			if let outEdges = edges[v],
			   let next = outEdges.keys
				.first(where: { visited.insert($0).inserted }),
			   let weight = outEdges[next]
			{
				weights.append(weight)
				path.append(next)
			} else {
				weights.removeLast()
				path.removeLast()
			}
		}

		result.append(
			path.isEmpty ? -1 : weights.reduce(into: 1, *=)
		)
	}

	return result
}

/// Course schedule
///
/// There are a total of `numCourses` courses you have to take, labeled from `0`
/// to `numCourses - 1`. You are given an array `prerequisites` where
/// `prerequisites[i] = [ai, bi]` indicates that you **must** take course `bi`
/// first if you want to take course `ai`.
///
/// - For example, the pair `[0, 1]`, indicates that to take course `0` you have
///   to first take course `1`.
///
/// Return `true` if you can finish all courses. Otherwise, return `false`.
func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
	var prerequisiteCounts = [Int](repeating: 0, count: numCourses)
	var followingCourses = [Int: Set<Int>]()

	for prerequisite in prerequisites {
		let (a, b) = (prerequisite[0], prerequisite[1])
		prerequisiteCounts[a] += 1
		followingCourses[b, default: []].insert(a)
	}

	var coursesToTake = Set<Int>()
	var coursesTaken = 0

	for (course, count) in prerequisiteCounts.enumerated() where count == 0 {
		coursesToTake.insert(course)
	}

	while let course = coursesToTake.popFirst() {
		coursesTaken += 1
		for course in followingCourses[course, default: []] {
			prerequisiteCounts[course] -= 1
			if prerequisiteCounts[course] == 0 {
				coursesToTake.insert(course)
			}
		}
	}

	return coursesTaken == numCourses
}

/// Course schedule II
///
/// There are a total of `numCourses` courses you have to take, labeled from `0`
/// to `numCourses - 1`. You are given an array `prerequisites` where
/// `prerequisites[i] = [ai, bi]` indicates that you **must** take course `bi`
/// first if you want to take course `ai`.
///
/// - For example, the pair `[0, 1]`, indicates that to take course `0` you have
///   to first take course `1`.
///
/// Return _the ordering of courses you should take to finish all courses_. If
/// there are many valid answers, return **any** of them. If it is impossible to
/// finish all courses, return **an empty array**.
func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
	[]
}

/// Snakes and ladders
///
/// You are given an `n x n` integer matrix `board` where the cells are labeled
/// from `1` to `n^2` in a **Boustrophedon style** starting from the bottom left
/// of the board (i.e. `board[n - 1][0]`) and alternating direction each row.
///
/// You start on square `1` of the board. In each move, starting from square
/// `curr`, do the following:
///
/// - Choose a destination square `next` with a label in the range
///   `[curr + 1, min(curr + 6, n^2)]`.
///   - This choice simulates the result of a standard **6-sided die roll**:
///     i.e., there are always at most 6 destinations, regardless of the size of
///     the board.
/// - If `next` has a snake or ladder, you **must** move to the destination of
///   that snake or ladder. Otherwise, you move to `next`.
/// - The game ends when you reach the square `n^2`.
///
/// A board square on row `r` and column `c` has a snake or ladder if
/// `board[r][c] != -1`. The destination of that snake or ladder is
/// `board[r][c]`. Squares `1` and `n^2` do not have a snake or ladder.
///
/// Note that you only take a snake or ladder at most once per move. If the
/// destination to a snake or ladder is the start of another snake or ladder,
/// you do **not** follow the subsequent snake or ladder.
///
/// - For example, suppose the board is `[[-1,4],[-1,3]]`, and on the first
///   move, your destination square is `2`. You follow the ladder to square `3`,
///   but do **not** follow the subsequent ladder to `4`.
///
/// Return _the least number of moves required to reach the square `n^2`. If it
/// is not possible to reach the square, return `-1`_.
func snakesAndLadders(_ board: [[Int]]) -> Int {
	0
}

/// Minimum genetic mutation
///
/// A gene string can be represented by an 8-character long string, with choices
/// from `'A'`, `'C'`, `'G'`, and `'T'`.
///
/// Suppose we need to investigate a mutation from a gene string `startGene` to
/// a gene string `endGene` where one mutation is defined as one single
/// character changed in the gene string.
///
/// - For example, `"AACCGGTT" --> "AACCGGTA"` is one mutation.
///
/// There is also a gene bank `bank` that records all the valid gene mutations.
/// A gene must be in `bank` to make it a valid gene string.
///
/// Given the two gene strings `startGene` and `endGene` and the gene bank
/// `bank`, return _the minimum number of mutations needed to mutate from
/// `startGene` to `endGene`_. If there is no such a mutation, return `-1`.
///
/// Note that the starting point is assumed to be valid, so it might not be
/// included in the bank.
func minMutation(_ startGene: String, _ endGene: String, _ bank: [String]) -> Int {
	0
}
