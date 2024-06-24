import Testing

struct TestCase<T, U>: Encodable, CustomTestStringConvertible
where T: Encodable, U: Encodable {
	let given: DataType<T>
	let expected: DataType<U>

	var testDescription: String {
		"Given \(given.testDescription), expecting \(expected.testDescription)"
	}
}

extension TestCase {
	enum DataType<V>: Encodable, CustomTestStringConvertible where V: Encodable {
		case one(V)
		case many([V])
		case oneAndMany(V, [V])
		case manyAndMany([V], [V])

		var getOne: V? {
			switch self {
				case let .one(a): a
				default: nil
			}
		}

		var getMany: [V]? {
			switch self {
				case let .many(a): a
				default: nil
			}
		}

		var getOneAndMany: (V, [V])? {
			switch self {
				case let .oneAndMany(a, b): (a, b)
				default: nil
			}
		}

		var getManyAndMany: ([V], [V])? {
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
