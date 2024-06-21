import Testing
@testable import LeetCode

extension Array where Element: Comparable {
	func isSorted() -> Bool {
		self == sorted()
	}
}

extension [Int] {
	func countExcludingTrailingZeros() -> Int {
		if let lastNonZero = lastIndex(where: { $0 != 0 }) {
			lastNonZero + 1
		} else {
			0
		}
	}
}

@Test("Merge sorted arrays", arguments: [
	.init(
		given: .manyAndMany([1, 2, 3, 0, 0, 0], [2, 5, 6]),
		expected: .many([1, 2, 2, 3, 5, 6])
	),
	.init(given: .manyAndMany([1], []), expected: .many([1])),
	.init(given: .manyAndMany([0], [1]), expected: .many([1])),
] as [TestCase<Int>])
func testMergeSortedArrays(t: TestCase<Int>) throws {
	var (a, b) = try #require(t.given.getManyAndMany)
	let expected = try #require(t.expected.getMany)
	let (m, n) = (
		a.countExcludingTrailingZeros(),
		b.count
	)
	try #require(m >= 0 && n >= 0 && m + n >= 1 && a.count == m + n)
	mergeSortedArrays(&a, m, b, n)
	#expect(a == expected)
}

@Test("Remove element", arguments: [
	.init(
		given: .oneAndMany(3, [3, 2, 2, 3]),
		expected: .many([2, 2])
	),
	.init(
		given: .oneAndMany(2, [0, 1, 2, 2, 3, 0, 4, 2]),
		expected: .many([0, 1, 4, 0, 3])
	),
	.init(given: .oneAndMany(1, []), expected: .many([])),
	.init(given: .oneAndMany(1, [2]), expected: .many([2])),
	.init(given: .oneAndMany(3, [3, 3]), expected: .many([])),
] as [TestCase<Int>])
func testRemoveElement(t: TestCase<Int>) throws {
	var (number, nums) = try #require(t.given.getOneAndMany)
	let expected = try #require(t.expected.getMany)
	try #require(number >= 0 && number <= 100)
	let k = removeElement(&nums, number)
	#expect(k == expected.count)
	#expect(Set(nums[..<k]) == Set(expected))
}

@Test("Remove duplicates from sorted array", arguments: [
	.init(given: .many([1, 1, 2]), expected: .many([1, 2])),
	.init(
		given: .many([0, 0, 1, 1, 1, 2, 2, 3, 3, 4]),
		expected: .many([0, 1, 2, 3, 4])
	),
	.init(given: .many([1]), expected: .many([1])),
	.init(given: .many([1, 1]), expected: .many([1])),
	.init(given: .many([]), expected: .many([])),
] as [TestCase<Int>])
func testRemoveDuplicates(t: TestCase<Int>) throws {
	var nums = try #require(t.given.getMany)
	let expected = try #require(t.expected.getMany)
	try #require(nums.isSorted() && expected.isSorted())
	let k = removeDuplicates(&nums)
	#expect(k == expected.count)
	#expect(nums[..<k] == expected[...])
}

@Test("Remove duplicates from sorted array while keeping at most two", arguments: [
	.init(
		given: .many([1, 1, 1, 2, 2, 3]),
		expected: .many([1, 1, 2, 2, 3])
	),
	.init(
		given: .many([0, 0, 1, 1, 1, 1, 2, 3, 3]),
		expected: .many([0, 0, 1, 1, 2, 3, 3])
	),
	.init(given: .many([]), expected: .many([])),
	.init(given: .many([1]), expected: .many([1])),
	.init(given: .many([1, 1]), expected: .many([1, 1])),
	.init(given: .many([1, 1, 1]), expected: .many([1, 1])),
] as [TestCase<Int>])
func testRemoveDuplicatesWhileKeepingAtMostTwo(t: TestCase<Int>) throws {
	var nums = try #require(t.given.getMany)
	let expected = try #require(t.expected.getMany)
	try #require(nums.isSorted() && expected.isSorted())
	let k = removeDuplicatesWhileKeepingAtMostTwo(&nums)
	#expect(k == expected.count)
	#expect(nums[..<k] == expected[...])
}
