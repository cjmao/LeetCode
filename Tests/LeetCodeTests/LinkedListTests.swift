import Testing
@testable import LeetCode

@Suite("Linked list")
struct LinkedListTests {
	@Test("Linked list cycle", arguments: [
		TestCase(given: Pair([3, 2, 0, -4], 1), expected: true),
		TestCase(given: Pair([1, 2], 0), expected: true),
		TestCase(given: Pair([1], -1), expected: false),
	])
	func testHasCycle(c: TestCase<Pair<[Int], Int>, Bool>) throws {
		let ((head, pos), expected) = (c.given.values, c.expected)
		try #require(pos >= -1)
		let list = LinkedList(head)
		list.tail?.next = list[pos]
		#expect(hasCycle(list.head) == expected)
	}

	@Test("Add two numbers", arguments: [
		TestCase(given: Pair([2, 4, 3], [5, 6, 4]), expected: [7, 0, 8]),
		TestCase(given: Pair([0], [0]), expected: [0]),
		TestCase(
			given: Pair([9, 9, 9, 9, 9, 9, 9], [9, 9, 9, 9]),
			expected: [8, 9, 9, 9, 0, 0, 0, 1]
		),
	])
	func testAddTwoNumbers(c: TestCase<Pair<[Int], [Int]>, [Int]>) throws {
		let ((l1, l2), expected) = (c.given.values, c.expected)

		try #require([l1, l2].allSatisfy {
			$0.count >= 1 && $0.count <= 100 && $0.allSatisfy {
				$0 >= 0 && $0 <= 9
			}
		})

		let list1 = LinkedList(l1)
		let list2 = LinkedList(l2)

		let sum = addTwoNumbers(list1.head, list2.head)
		#expect(Array(sum) == Array(expected))
	}

	@Test("Merge two sorted lists", arguments: [
		TestCase(
			given: Pair([1, 2, 4], [1, 3, 4]),
			expected: [1, 1, 2, 3, 4, 4]
		),
		TestCase(given: Pair([], []), expected: []),
		TestCase(given: Pair([], [0]), expected: [0]),
	])
	func testMergeTwoLists(c: TestCase<Pair<[Int], [Int]>, [Int]>) throws {
		let ((l1, l2), expected) = (c.given.values, c.expected)

		try #require([l1, l2].allSatisfy {
			$0.count >= 0 && $0.count <= 50 && $0.allSatisfy {
				$0 >= -100 && $0 <= 100
			}
		})

		let list1 = LinkedList(l1)
		let list2 = LinkedList(l2)

		let merged = mergeTwoLists(list1.head, list2.head)
		#expect(Array(merged) == Array(expected))
	}

	@Test("Copy list with random pointer", arguments: [
		TestCase(
			given: [[7, nil], [13, 0], [11, 4], [10, 2], [1, 0]],
			expected: [[7, nil], [13, 0], [11, 4], [10, 2], [1, 0]]
		),
		TestCase(
			given: [[1, 1], [2, 1]],
			expected: [[1, 1], [2, 1]]
		),
		TestCase(
			given: [[3, nil], [3, 0], [3, nil]],
			expected: [[3, nil], [3, 0], [3, nil]]
		),
	])
	func testCopyRandomList(c: TestCase<[[Int?]], [[Int?]]>) throws {
		let (head, expected) = (c.given, c.expected)

		let originalList = LinkedList(head)
		try #require(originalList.count >= 0 && originalList.count <= 1000)

		let copyOfList = LinkedList(copyRandomList(originalList.head))
		let expectedList = LinkedList(expected)

		#expect(Array(copyOfList) == Array(expectedList))

		let copiesOfNodes: [ObjectIdentifier: ListNode] = zip(
			originalList.nodes, copyOfList.nodes
		).reduce(into: [:]) { map, nodes in
			let (original, copy) = nodes
			map[ObjectIdentifier(original)] = copy
		}

		for (original, copy) in zip(originalList.nodes, copyOfList.nodes) {
			guard let random = original.random else {
				#expect(copy.random == nil)
				continue
			}

			#expect(copy.random != nil)

			let randomOfCopy = copy.random
			let copyOfRandom = copiesOfNodes[.init(random)]!

			// The following does not work and would cause a crash
			// #expect(copyOfRandom !== random)

			// The following asserts the same thing
			#expect(ObjectIdentifier(copyOfRandom) != ObjectIdentifier(random))

			#expect(copyOfRandom === randomOfCopy)
		}
	}

	@Test("Reverse linked list II", arguments: [
		TestCase(
			given: Pair([1, 2, 3, 4, 5], Pair(2, 4)),
			expected: [1, 4, 3, 2, 5]
		),
		TestCase(given: Pair([5], Pair(1, 1)), expected: [5]),
		TestCase(given: Pair([3, 5], Pair(1, 1)), expected: [3, 5]),
		TestCase(given: Pair([3, 5], Pair(1, 2)), expected: [5, 3]),
		TestCase(given: Pair([3, 5], Pair(2, 2)), expected: [3, 5]),
	])
	func testReverseBetween(c: TestCase<Pair<[Int], Pair<Int, Int>>, [Int]>) throws {
		let ((head, leftAndRight), expected) = (c.given.values, c.expected)
		let (left, right) = leftAndRight.values

		let list = LinkedList(head)
		let expectedList = LinkedList(expected)

		try #require(list.count >= 1 && list.count <= 500)
		try #require(list.nodes.allSatisfy { $0.val >= -500 && $0.val <= 500 })
		try #require(1 <= left && left <= right && right <= list.count)

		let reversed = reverseBetween(list.head, left, right)
		#expect(Array(reversed) == Array(expectedList))
	}

	@Test("Reverse nodes in k-group", arguments: [
		TestCase(given: Pair([1, 2, 3, 4, 5], 2), expected: [2, 1, 4, 3, 5]),
		TestCase(given: Pair([1, 2, 3, 4, 5], 3), expected: [3, 2, 1, 4, 5]),
		TestCase(given: Pair([1, 2, 3, 4, 5], 1), expected: [1, 2, 3, 4, 5]),
	])
	func testReverseKGroup(c: TestCase<Pair<[Int], Int>, [Int]>) throws {
		let ((head, k), expected) = (c.given.values, c.expected)

		var list = LinkedList(head)
		try #require(1 <= k && k <= list.count && list.count <= 5000)
		try #require(list.nodes.allSatisfy { $0.val >= 0 && $0.val <= 1000 })

		list.head = reverseKGroup(list.head, k)
		#expect(Array(list) == expected)
	}

	@Test("Remove nth node from end of list", arguments: [
		TestCase(given: Pair([1, 2, 3, 4, 5], 2), expected: [1, 2, 3, 5]),
		TestCase(given: Pair([1], 1), expected: []),
		TestCase(given: Pair([1, 2], 1), expected: [1]),
	])
	func testRemoveNthFromEnd(c: TestCase<Pair<[Int], Int>, [Int]>) throws {
		let ((head, n), expected) = (c.given.values, c.expected)

		let list = LinkedList(head)
		try #require(list.count >= 1 && list.count <= 30)
		try #require(list.nodes.allSatisfy { $0.val >= 0 && $0.val <= 100 })
		try #require(1 <= n && n <= list.count)

		let result = LinkedList(removeNthFromEnd(list.head, n))
		#expect(Array(result) == expected)
	}

	@Test("Remove duplicates from sorted list II", arguments: [
		TestCase(given: [1, 2, 3, 3, 4, 4, 5], expected: [1, 2, 5]),
		TestCase(given: [1, 1, 1, 2, 3], expected: [2, 3]),
	])
	func testDeleteDuplicates(c: TestCase<[Int], [Int]>) throws {
		let (head, expected) = (c.given, c.expected)

		let list = LinkedList(head)
		try #require(list.count <= 300)
		try #require(list.nodes.allSatisfy { $0.val >= -100 && $0.val <= 100 })
		try #require(list.nodes.map(\.val).isSorted())

		let result = deleteDuplicates(list.head)
		#expect(Array(result) == expected)
	}

	@Test("Rotate list", arguments: [
		TestCase(given: Pair([1, 2, 3, 4, 5], 2), expected: [4, 5, 1, 2, 3]),
		TestCase(given: Pair([0, 1, 2], 4), expected: [2, 0, 1]),
	])
	func testRotateRight(c: TestCase<Pair<[Int], Int>, [Int]>) throws {
		let ((head, k), expected) = (c.given.values, c.expected)

		let list = LinkedList(head)
		try #require(list.count <= 500)
		try #require(list.nodes.allSatisfy { $0.val >= -100 && $0.val <= 100 })
		try #require(k >= 0)

		let result = rotateRight(list.head, k)
		#expect(Array(result) == expected)
	}

	@Test("Partition list", arguments: [
		TestCase(given: Pair([1, 4, 3, 2, 5, 2], 3), expected: [1, 2, 2, 4, 3, 5]),
		TestCase(given: Pair([2, 1], 2), expected: [1, 2]),
	])
	func testPartition(c: TestCase<Pair<[Int], Int>, [Int]>) throws {
		let ((head, x), expected) = (c.given.values, c.expected)

		let list = LinkedList(head)
		try #require(list.count <= 200)
		try #require(list.nodes.allSatisfy { $0.val >= -100 && $0.val <= 100 })
		try #require(-200 <= x && x <= 200)

		let result = partition(list.head, x)
		#expect(Array(result) == expected)
	}
}

extension LinkedList {
	init(_ nodes: [[Int?]]) {
		self.init([Int]())

		for node in nodes {
			let node = ListNode(node[0]!)
			if head != nil, let tail {
				tail.next = node
				self.tail = node
			} else {
				head = node
				tail = node
			}
			count += 1
		}

		var current = head

		for node in nodes {
			if let i = node[1] {
				current?.random = self[i]
			}
			current = current?.next
		}
	}

	var nodes: some Sequence<ListNode> {
		sequence(first: head, next: { $0?.next })
			.lazy
			.compactMap(\.self)
	}
}

extension [Int] {
	init(_ list: LinkedList) {
		self.init(list.head)
	}

	init(_ listHead: ListNode?) {
		self = sequence(first: listHead, next: { $0?.next })
			.compactMap { $0?.val }
	}
}
