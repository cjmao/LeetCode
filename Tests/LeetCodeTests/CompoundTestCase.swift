import Testing

struct CompoundTestCase<
	GivenA, GivenB, ExpectedA, ExpectedB
>: Encodable, Sendable, CustomTestStringConvertible
where GivenA: Encodable & Sendable, GivenB: Encodable & Sendable,
	  ExpectedA: Encodable & Sendable, ExpectedB: Encodable & Sendable {
	let given: CompoundDataType<GivenA, GivenB>
	let expected: CompoundDataType<ExpectedA, ExpectedB>

	var testDescription: String {
		"Given \(given.testDescription), expecting \(expected.testDescription)"
	}
}

extension CompoundTestCase {
	enum CompoundDataType<A, B>: Encodable, Sendable, CustomTestStringConvertible
	where A: Encodable & Sendable, B: Encodable & Sendable {
		case one(A)
		case many([A])
		case oneAndOne(A, B)
		case oneAndMany(A, [B])
		case manyAndMany([A], [B])

		var getOne: A? {
			switch self {
				case let .one(a): a
				default: nil
			}
		}

		var getMany: [A]? {
			switch self {
				case let .many(a): a
				default: nil
			}
		}

		var getOneAndOne: (A, B)? {
			switch self {
				case let .oneAndOne(a, b): (a, b)
				default: nil
			}
		}

		var getOneAndMany: (A, [B])? {
			switch self {
				case let .oneAndMany(a, b): (a, b)
				default: nil
			}
		}

		var getManyAndMany: ([A], [B])? {
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
