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

/// Find peak element
///
/// A peak element is an element that is strictly greater than its neighbors.
///
/// Given a **0-indexed** integer array `nums`, find a peak element, and return
/// its index. If the array contains multiple peaks, return the index to **any
/// of the peaks**.
///
/// You may imagine that `nums[-1] = nums[n] = -∞`. In other words, an element
/// is always considered to be strictly greater than a neighbor that is outside
/// the array.
///
/// You must write an algorithm that runs in `O(log n)` time.
func findPeakElement(_ nums: [Int]) -> Int {
	0
}

/// Search in rotated sorted array
///
/// There is an integer array `nums` sorted in ascending order (with
/// **distinct** values).
///
/// Prior to being passed to your function, `nums` is **possibly rotated** at an
/// unknown pivot index `k` (`1 <= k < nums.length`) such that the resulting
/// array is `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ...,
/// nums[k-1]]` (**0-indexed**). For example, `[0,1,2,4,5,6,7]` might be rotated
/// at pivot index `3` and become `[4,5,6,7,0,1,2]`.
///
/// Given the array `nums` **after** the possible rotation and an integer
/// `target`, return _the index of `target` if it is in `nums`, or `-1` if it is
/// not in nums_.
///
/// You must write an algorithm with `O(log n)` runtime complexity.
func search(_ nums: [Int], _ target: Int) -> Int {
	-1
}
