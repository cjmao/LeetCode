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
		#expect(LinkedList(sum) == LinkedList(expected))
	}
}
