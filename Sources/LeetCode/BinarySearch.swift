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

/// Search a 2D matrix
///
/// You are given an `m x n` integer matrix `matrix` with the following two
/// properties:
///
/// - Each row is sorted in non-decreasing order.
/// - The first integer of each row is greater than the last integer of the
///   previous row.
///
/// Given an integer `target`, return _`true` if `target` is in `matrix` or
/// `false` otherwise_.
///
/// You must write a solution in `O(log(m * n))` time complexity.
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
	false
}
