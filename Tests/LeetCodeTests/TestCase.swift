import Testing

typealias TestData = Encodable & Sendable & CustomTestStringConvertible

struct TestCase<Given, Expected>: TestData
where Given: TestData, Expected: TestData {
	let given: Given
	let expected: Expected

	var testDescription: String {
		"given: \(given.testDescription), expecting: \(expected.testDescription)"
	}
}

struct Pair<A, B>: TestData where A: TestData, B: TestData {
	let a: A
	let b: B

	init(_ a: A, _ b: B) {
		self.a = a
		self.b = b
	}

	var values: (A, B) { (a, b) }

	var testDescription: String {
		"(\(a.testDescription), \(b.testDescription))"
	}
}

extension Bool: @retroactive CustomTestStringConvertible {
	public var testDescription: String { description }
}

extension Int: @retroactive CustomTestStringConvertible {
	public var testDescription: String { description }
}

extension Double: @retroactive CustomTestStringConvertible {
	public var testDescription: String { description }
}

extension Array: @retroactive CustomTestStringConvertible {
	public var testDescription: String { description }
}
