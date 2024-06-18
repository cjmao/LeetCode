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
