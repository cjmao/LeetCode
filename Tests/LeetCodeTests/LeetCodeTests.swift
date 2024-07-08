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
] as [TestCase<Int, Int>])
func testMergeSortedArrays(t: TestCase<Int, Int>) throws {
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
] as [TestCase<Int, Int>])
func testRemoveElement(t: TestCase<Int, Int>) throws {
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
] as [TestCase<Int, Int>])
func testRemoveDuplicates(t: TestCase<Int, Int>) throws {
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
] as [TestCase<Int, Int>])
func testRemoveDuplicatesWhileKeepingAtMostTwo(t: TestCase<Int, Int>) throws {
	var nums = try #require(t.given.getMany)
	let expected = try #require(t.expected.getMany)
	try #require(nums.isSorted() && expected.isSorted())
	let k = removeDuplicatesWhileKeepingAtMostTwo(&nums)
	#expect(k == expected.count)
	#expect(nums[..<k] == expected[...])
}

@Test("Majority element", arguments: [
	.init(given: .many([3, 2, 3]), expected: .one(3)),
	.init(given: .many([2, 2, 1, 1, 1, 2, 2]), expected: .one(2)),
] as [TestCase<Int, Int>])
func testMajorityElement(t: TestCase<Int, Int>) throws {
	let nums = try #require(t.given.getMany)
	let expected = try #require(t.expected.getOne)
	let m = majorityElement(nums)
	#expect(m == expected)
}

@Test("Rotate array", arguments: [
	.init(
		given: .oneAndMany(3, [1, 2, 3, 4, 5, 6, 7]),
		expected: .many([5, 6, 7, 1, 2, 3, 4])
	),
	.init(
		given: .oneAndMany(2, [-1, -100, 3, 99]),
		expected: .many([3, 99, -1, -100])
	),
	.init(
		given: .oneAndMany(1, [1, 2, 3, 4, 5, 6, 7]),
		expected: .many([7, 1, 2, 3, 4, 5, 6])
	),
] as [TestCase<Int, Int>])
func testRotateArray(t: TestCase<Int, Int>) throws {
	var (k, nums) = try #require(t.given.getOneAndMany)
	let expected = try #require(t.expected.getMany)
	try #require(k >= 0 && nums.count > 0)
	rotate(&nums, k)
	#expect(nums == expected)
}

@Test("Best time to buy and sell stock", arguments: [
	.init(
		given: .many([7, 1, 5, 3, 6, 4]),
		expected: .one(5)
	),
	.init(
		given: .many([7, 6, 4, 3, 1]),
		expected: .one(0)
	),
	.init(
		given: .many([1]),
		expected: .one(0)
	),
] as [TestCase<Int, Int>])
func testMaxProfit(t: TestCase<Int, Int>) throws {
	let prices = try #require(t.given.getMany)
	let expected = try #require(t.expected.getOne)
	try #require(!prices.isEmpty && prices.allSatisfy { $0 >= 0 })
	let profit = maxProfit(prices)
	#expect(profit == expected)
}

@Test("Best time to buy and sell stock II", arguments: [
	.init(
		given: .many([7, 1, 5, 3, 6, 4]),
		expected: .one(7)
	),
	.init(
		given: .many([1, 2, 3, 4, 5]),
		expected: .one(4)
	),
	.init(
		given: .many([7, 6, 4, 3, 1]),
		expected: .one(0)
	),
	.init(
		given: .many([6, 1, 3, 2, 4, 7]),
		expected: .one(7)
	),
] as [TestCase<Int, Int>])
func testMaxProfitAllowingSellingOnSameDay(t: TestCase<Int, Int>) throws {
	let prices = try #require(t.given.getMany)
	let expected = try #require(t.expected.getOne)
	try #require(!prices.isEmpty && prices.allSatisfy { $0 >= 0 })
	let profit = maxProfitAllowingSellingOnSameDay(prices)
	#expect(profit == expected)
}

@Test("Jump game", arguments: [
	.init(
		given: .many([2, 3, 1, 1, 4]),
		expected: .one(true)
	),
	.init(
		given: .many([3, 2, 1, 0, 4]),
		expected: .one(false)
	),
	.init(
		given: .many([1, 2, 1, 0, 0]),
		expected: .one(false)
	),
	.init(
		given: .many([1, 2, 3, 4, 0]),
		expected: .one(true)
	),
	.init(
		given: .many([0]),
		expected: .one(true)
	),
	.init(
		given: .many([1]),
		expected: .one(true)
	),
] as [TestCase<Int, Bool>])
func testJumpGame(t: TestCase<Int, Bool>) throws {
	let nums = try #require(t.given.getMany)
	try #require(!nums.isEmpty && nums.allSatisfy { $0 >= 0 })
	let expected = try #require(t.expected.getOne as Bool?)
	let result = canJump(nums)
	#expect(result == expected)
}

@Test("Jump game II", arguments: [
	.init(
		given: .many([2, 3, 1, 1, 4]),
		expected: .one(2)
	),
	.init(
		given: .many([2, 3, 0, 1, 4]),
		expected: .one(2)
	),
	.init(
		given: .many([0]),
		expected: .one(0)
	),
] as [TestCase<Int, Int>])
func testMinimumStepsOfJumpGame(t: TestCase<Int, Int>) throws {
	let nums = try #require(t.given.getMany)
	try #require(!nums.isEmpty && nums.allSatisfy { $0 >= 0 })
	let expected = try #require(t.expected.getOne)
	let result = jump(nums)
	#expect(result == expected)
}

@Test("H-index", arguments: [
	.init(
		given: .many([3, 0, 6, 1, 5]),
		expected: .one(3)
	),
	.init(
		given: .many([1, 3, 1]),
		expected: .one(1)
	),
	.init(
		given: .many([0]),
		expected: .one(0)
	),
	.init(
		given: .many([1]),
		expected: .one(1)
	),
	.init(
		given: .many([100]),
		expected: .one(1)
	),
	.init(
		given: .many([4, 4, 0, 0]),
		expected: .one(2)
	),
] as [TestCase<Int, Int>])
func testHIndex(t: TestCase<Int, Int>) throws {
	let nums = try #require(t.given.getMany)
	let expected = try #require(t.expected.getOne)
	try #require(nums.count > 0 && nums.allSatisfy { $0 >= 0 })
	let h = hIndex(nums)
	#expect(h == expected)
}

@Test("Product of array except self", arguments: [
	.init(
		given: .many([1, 2, 3, 4]),
		expected: .many([24, 12, 8, 6])
	),
	.init(
		given: .many([-1, 1, 0, -3, 3]),
		expected: .many([0, 0, 9, 0, 0])
	),
	.init(
		given: .many([2, 3]),
		expected: .many([3, 2])
	),
] as [TestCase<Int, Int>])
func testProductExceptSelf(t: TestCase<Int, Int>) throws {
	let nums = try #require(t.given.getMany)
	let expected = try #require(t.expected.getMany)
	try #require(nums.count >= 2 && nums.count == expected.count)
	let product = productExceptSelf(nums)
	#expect(product == expected)
}

@Test("Gas station", arguments: [
	.init(
		given: .manyAndMany(
			[1, 2, 3, 4, 5],
			[3, 4, 5, 1, 2]
		),
		expected: .one(3)
	),
	.init(
		given: .manyAndMany(
			[2, 3, 4],
			[3, 4, 3]
		),
		expected: .one(-1)
	),
] as [TestCase<Int, Int>])
func testGasStation(t: TestCase<Int, Int>) throws {
	let (gas, cost) = try #require(t.given.getManyAndMany)
	let expected = try #require(t.expected.getOne)

	try #require(!gas.isEmpty && gas.count == cost.count)
	try #require(gas.allSatisfy { $0 >= 0 })
	try #require(cost.allSatisfy { $0 >= 0 })

	let canComplete = canCompleteCircuit(gas, cost)
	#expect(canComplete == expected)
}

@Test("Candy", arguments: [
	.init(
		given: .many([1, 0, 2]),
		expected: .one(5)
	),
	.init(
		given: .many([1, 2, 2]),
		expected: .one(4)
	),
	.init(
		given: .many([1, 2, 1, 3, 4, 2]),
		expected: .one(10)
	),
	.init(
		given: .many([1, 2, 87, 87, 2, 1]),
		expected: .one(12)
	),
	.init(
		given: .many([0, 1, 2, 5, 3, 2, 7]),
		expected: .one(15)
	),
	.init(
		given: .many([1, 6, 10, 8, 7, 3, 2]),
		expected: .one(18)
	),
] as [TestCase<Int, Int>])
func testCandy(t: TestCase<Int, Int>) throws {
	let ratings = try #require(t.given.getMany)
	let expected = try #require(t.expected.getOne)
	try #require(!ratings.isEmpty && ratings.allSatisfy { $0 >= 0 })
	let candies = candy(ratings)
	#expect(candies == expected)
}

@Test("Trapping rain water", arguments: [
	.init(
		given: .many([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]),
		expected: .one(6)
	),
	.init(
		given: .many([4, 2, 0, 3, 2, 5]),
		expected: .one(9)
	),
	.init(
		given: .many([4, 2, 3]),
		expected: .one(1)
	),
] as [TestCase<Int, Int>])
func testTrappingRainWater(t: TestCase<Int, Int>) throws {
	let height = try #require(t.given.getMany)
	let expected = try #require(t.expected.getOne)
	try #require(!height.isEmpty && height.allSatisfy { $0 >= 0 })
	let trappedWater = trap(height)
	#expect(trappedWater == expected)
}
