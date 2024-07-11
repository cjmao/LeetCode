import Testing

struct TestCase<Given, Expected>: Encodable, Sendable, CustomTestStringConvertible
where Given: Encodable & Sendable, Expected: Encodable & Sendable {
	let given: DataType<Given>
	let expected: DataType<Expected>

	var testDescription: String {
		"Given \(given.testDescription), expecting \(expected.testDescription)"
	}
}

extension TestCase {
	enum DataType<T>: Encodable, Sendable, CustomTestStringConvertible
	where T: Encodable & Sendable {
		case one(T)
		case many([T])
		case oneAndOne(T, T)
		case oneAndMany(T, [T])
		case manyAndMany([T], [T])

		var getOne: T? {
			switch self {
				case let .one(a): a
				default: nil
			}
		}

		var getMany: [T]? {
			switch self {
				case let .many(a): a
				default: nil
			}
		}

		var getOneAndOne: (T, T)? {
			switch self {
				case let .oneAndOne(a, b): (a, b)
				default: nil
			}
		}

		var getOneAndMany: (T, [T])? {
			switch self {
				case let .oneAndMany(a, b): (a, b)
				default: nil
			}
		}

		var getManyAndMany: ([T], [T])? {
			switch self {
				case let .manyAndMany(a, b): (a, b)
				default: nil
			}
		}

		var testDescription: String {
			switch self {
				case let .one(a): "\(a)"
				case let .many(a): "\(a)"
				case let .oneAndOne(a, b): "\(a) and \(b)"
				case let .oneAndMany(a, b): "\(a) and \(b)"
				case let .manyAndMany(a, b): "\(a) and \(b)"
			}
		}
	}
}
