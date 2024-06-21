import Testing

struct TestCase<T>: Encodable, CustomTestStringConvertible where T: Encodable {
	let given: DataType
	let expected: DataType

	var testDescription: String {
		"Given \(given.testDescription), expecting \(expected.testDescription)"
	}
}

extension TestCase {
	enum DataType: Encodable, CustomTestStringConvertible where T: Encodable {
		case one(T)
		case many([T])
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
				case let .oneAndMany(a, b): "\(a) and \(b)"
				case let .manyAndMany(a, b): "\(a) and \(b)"
			}
		}
	}
}
