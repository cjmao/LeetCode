class GraphNode: CustomDebugStringConvertible {
	let val: Int
	var neighbours: [GraphNode]

	init(_ val: Int) {
		self.val = val
		self.neighbours = []
	}

	init?(_ adjacencyList: [[Int]]) {
		guard !adjacencyList.isEmpty else {
			return nil
		}

		let nodes = adjacencyList.indices.map { GraphNode($0 + 1) }

		for (i, neighbours) in adjacencyList.enumerated() {
			for neighbour in neighbours.sorted() {
				nodes[i].neighbours.append(nodes[neighbour - 1])
			}
		}

		self.val = nodes[0].val
		self.neighbours = nodes[0].neighbours
	}

	var debugDescription: String {
		"\(val)"
	}

	func breadthFirstTraversal() -> some Sequence<[GraphNode]> {
		var visited = [val] as Set

		return sequence(first: [self]) { previous in
			var next = [GraphNode]()

			for node in previous {
				for neighbour in node.neighbours
				where !visited.contains(neighbour.val) {
					visited.insert(neighbour.val)
					next.append(neighbour)
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
	nil
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
	[]
}
