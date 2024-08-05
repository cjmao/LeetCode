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
}
