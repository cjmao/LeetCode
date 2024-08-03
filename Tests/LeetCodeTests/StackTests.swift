import Testing
@testable import LeetCode

@Suite("Stack")
struct StackTests {
	@Test("Valid parentheses", arguments: [
		TestCase(given: "()", expected: true),
		TestCase(given: "()[]{}", expected: true),
		TestCase(given: "(]", expected: false),
	])
	func testValidParentheses(c: TestCase<String, Bool>) throws {
		let (s, expected) = (c.given, c.expected)
		let characters = Set("()[]{}")
		try #require(!s.isEmpty && s.allSatisfy { characters.contains($0) })
		#expect(isValid(s) == expected)
	}

	@Test("Simplify path", arguments: [
		TestCase(given: "/home/", expected: "/home"),
		TestCase(given: "/home//foo/", expected: "/home/foo"),
		TestCase(
			given: "/home/user/Documents/../Pictures",
			expected: "/home/user/Pictures"
		),
		TestCase(given: "/../", expected: "/"),
		TestCase(given: "/.../a/../b/c/../d/./", expected: "/.../b/d"),
	])
	func testSimplifyPath(c: TestCase<String, String>) throws {
		let (path, expected) = (c.given, c.expected)

		try #require(!path.isEmpty && path.wholeMatch(
			of: /([[:alnum:]]|\.|\/|_)+/
		) != nil)

		#expect(simplifyPath(path) == expected)
	}

	@Test("Min stack", arguments: [
		TestCase(
			given: [
				.initialize, .push(-2), .push(0), .push(-3),
				.getMin, .pop, .top, .getMin,
			] as [MinStackOperation],
			expected: [
				nil, nil, nil, nil,
				-3, nil, 0, -2
			]
		)
	])
	func testMinStack(c: TestCase<[MinStackOperation], [Int?]>) throws {
		let (operations, expected) = (c.given, c.expected)

		try #require(operations.count == expected.count)

		let stack = MinStack()

		for (operation, expected) in zip(operations, expected) {
			switch operation {
				case .initialize:
					break
				case .push(let num):
					stack.push(num)
				case .pop:
					stack.pop()
				case .getMin:
					#expect(stack.getMin() == expected)
				case .top:
					#expect(stack.top() == expected)
			}
		}
	}
}

enum MinStackOperation: Encodable {
	case initialize
	case push(Int)
	case pop
	case getMin
	case top
}
