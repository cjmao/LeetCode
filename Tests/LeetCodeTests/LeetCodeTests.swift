import Testing
@testable import LeetCode

extension [Int] {
	func countExcludingTrailingZeros() -> Int {
		if let lastNonZero = lastIndex(where: { $0 != 0 }) {
			lastNonZero + 1
		} else {
			0
		}
	}
}

@Test("Merge sorted arrays", arguments: zip([
	[[1,2,3,0,0,0], [2,5,6]],
	[[1], []],
	[[0], [1]]
], [
	[1,2,2,3,5,6],
	[1],
	[1]
]))
func testMergeSortedArrays(input: [[Int]], expected: [Int]) throws {
	try #require(input.count == 2)
	var nums1 = input[0]
	let nums2 = input[1]
	let (m, n) = (nums1.countExcludingTrailingZeros(), nums2.count)
	try #require(m >= 0 && n >= 0 && m + n >= 1 && nums1.count == m + n)
	mergeSortedArrays(&nums1, m, nums2, n)
	#expect(nums1 == expected)
}

@Test("Remove element", arguments: zip([
	[[3,2,2,3], [3]],
	[[0,1,2,2,3,0,4,2], [2]],
	[[], [1]],
	[[2], [1]],
	[[3, 3], [3]],
], [
	[[2,2], [2]],
	[[0,1,4,0,3], [5]],
	[[], [0]],
	[[2], [1]],
	[[], [0]],
]))
func testRemoveElement(input: [[Int]], expected: [[Int]]) throws {
	try #require(input.count == 2 && input[1].count == 1)
	try #require(expected.count == 2 && expected[1].count == 1)
	var nums = input[0]
	let (value, k) = (input[1][0], expected[1][0])
	try #require(value >= 0 && value <= 100)
	let removed = removeElement(&nums, value)
	#expect(removed == k)
	#expect(nums[..<k].sorted() == expected[0].sorted())
}

@Test("Remove duplicates from sorted array", arguments: zip([
	[1,1,2],
	[0,0,1,1,1,2,2,3,3,4],
	[1],
	[1,1],
	[],
], [
	[2,1,2],
	[5,0,1,2,3,4],
	[1,1],
	[1,1],
	[0],
]))
func testRemoveDuplicates(nums: [Int], expected: [Int]) throws {
	try #require(nums == nums.sorted())
	try #require(!expected.isEmpty)
	var nums = nums
	let (k, expected) = (expected.first!, expected[1...])
	let kActual = removeDuplicates(&nums)
	#expect(kActual == k)
	#expect(nums[..<k] == expected)
}
