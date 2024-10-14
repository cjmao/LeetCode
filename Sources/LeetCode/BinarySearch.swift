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
	let (m, n) = (matrix.count, matrix[0].count)

	var i = 0, j = m * n

	while i < j {
		let k = (i + j) / 2
		let num = matrix[k / n][k % n]
		if num < target {
			i = k + 1
		} else if num > target {
			j = k
		} else {
			return true
		}
	}

	return false
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
	var (i, j) = (nums.startIndex, nums.endIndex)

	while i < j {
		let m = (i + j) / 2

		let leftUp = (m == 0 || nums[m - 1] < nums[m])
		let rightDown = (m == nums.endIndex - 1 || nums[m] > nums[m + 1])

		if leftUp, rightDown {
			return m
		} else if leftUp {
			i = m + 1
		} else {
			j = m
		}
	}

	return -1
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
	var i = 0, j = nums.endIndex - 1

	if nums[i] > nums[j] {
		while i < j - 1 {
			let k = (i + j) / 2
			if nums[i] < nums[k] {
				i = k
			} else {
				j = k
			}
		}
		i = j
	}

	j = i + nums.count - 1

	while i <= j {
		let k = (i + j) / 2
		let num = nums[k % nums.count]
		if num < target {
			i = k + 1
		} else if num > target {
			j = k - 1
		} else {
			return k % nums.count
		}
	}

	return -1
}

/// Find first and last position of element in sorted array
///
/// Given an array of integers `nums` sorted in non-decreasing order, find the
/// starting and ending position of a given `target` value.
///
/// If `target` is not found in the array, return `[-1, -1]`.
///
/// You must write an algorithm with `O(log n)` runtime complexity.
func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
	[]
}

/// Find minimum in rotated sorted array
///
/// Suppose an array of length `n` sorted in ascending order is **rotated**
/// between `1` and `n` times. For example, the array `nums = [0,1,2,4,5,6,7]`
/// might become:
///
/// - `[4,5,6,7,0,1,2]` if it was rotated `4` times.
/// - `[0,1,2,4,5,6,7]` if it was rotated `7` times.
///
/// Notice that **rotating** an array `[a[0], a[1], a[2], ..., a[n-1]]` 1 time
/// results in the array `[a[n-1], a[0], a[1], a[2], ..., a[n-2]]`.
///
/// Given the sorted rotated array `nums` of **unique** elements, return _the
/// minimum element of this array_.
///
/// You must write an algorithm that runs in `O(log n)` time.
func findMin(_ nums: [Int]) -> Int {
	0
}

/// Median of two sorted arrays
///
/// Given two sorted arrays `nums1` and `nums2` of size `m` and `n`
/// respectively, return **the median** of the two sorted arrays.
///
/// The overall run time complexity should be `O(log (m+n))`.
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
	0
}
