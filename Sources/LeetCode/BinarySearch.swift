/// Search insert position
///
/// Given a sorted array of distinct integers and a target value, return the
/// index if the target is found. If not, return the index where it would be if
/// it were inserted in order.
///
/// You must write an algorithm with `O(log n)` runtime complexity.
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
	var i = nums.startIndex, j = nums.endIndex

	while i < j {
		let m = (i + j) / 2
		let n = nums[m]
		if n < target {
			i = m + 1
		} else if n > target {
			j = m
		} else {
			return m
		}
	}

	return i
}
