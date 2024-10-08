/// Summary ranges
///
/// You are given a sorted unique integer array `nums`.
///
/// A range `[a, b]` is the set of all integers from `a` to `b` (inclusive).
///
/// Return _the **smallest sorted** list of ranges that **cover all the numbers
/// in the array exactly**_. That is, each element of `nums` is covered by
/// exactly one of the ranges, and there is no integer `x` such that `x` is in
/// one of the ranges but not in nums.
///
/// Each range `[a, b]` in the list should be output as:
/// - `"a->b"` if `a != b`
/// - `"a"` if `a == b`
func summaryRanges(_ nums: [Int]) -> [String] {
	var intervals = [String]()

	var i = 0
	while i < nums.endIndex {
		var j = i + 1
		while j < nums.endIndex, nums[j] == nums[j - 1] + 1 {
			j += 1
		}
		let range = j - 1 == i ? "\(nums[i])" : "\(nums[i])->\(nums[j - 1])"
		intervals.append(range)
		i = j
	}

	return intervals
}

/// Merge intervals
///
/// Given an array of `intervals` where `intervals[i] = [start_i, end_i]`, merge
/// all overlapping intervals, and return _an array of the non-overlapping
/// intervals that cover all the intervals in the input_.
func merge(_ intervals: [[Int]]) -> [[Int]] {
	var result = [[Int]]()

	let sorted = intervals.sorted { $0[0] <= $1[0] }

	for interval in sorted {
		if let last = result.last, last[1] >= interval[0] {
			result[result.endIndex - 1][1] = max(last[1], interval[1])
		} else {
			result.append(interval)
		}
	}

	return result
}

/// Insert interval
///
/// You are given an array of non-overlapping `intervals` intervals where
/// `intervals[i] = [start_i, end_i]` represent the start and the end of the
/// `ith` interval and `intervals` is sorted in ascending order by `start_i`.
/// You are also given an interval `newInterval = [start, end]` that represents
/// the start and end of another interval.
///
/// Insert `newInterval` into `intervals` such that `intervals` is still sorted
/// in ascending order by `start_i` and `intervals` still does not have any
/// overlapping intervals (merge overlapping intervals if necessary).
///
/// Return _`intervals` after the insertion_.
///
/// **Note** that you don't need to modify `intervals` in-place. You can make a
/// new array and return it.
func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
	var merged = [[Int]]()
	var toBeMerged = newInterval

	for interval in intervals {
		if interval[1] < toBeMerged[0] {
			merged.append(interval)
		} else if toBeMerged[1] < interval[0] {
			merged.append(toBeMerged)
			toBeMerged = interval
		} else {
			toBeMerged = [
				min(toBeMerged[0], interval[0]),
				max(toBeMerged[1], interval[1])
			]
		}
	}

	merged.append(toBeMerged)

	return merged
}

/// Minimum number of arrows to burst balloons
///
/// There are some spherical balloons taped onto a flat wall that represents the
/// XY-plane.
/// The balloons are represented as a 2D integer array `points` where
/// `points[i] = [x_start, x_end]` denotes a balloon whose **horizontal
/// diameter** stretches between `x_start` and `x_end`.
/// You do not know the exact y-coordinates of the balloons.
///
/// Arrows can be shot up `directly vertically` (in the positive y-direction)
/// from different points along the x-axis.
/// A balloon with `x_start` and `x_end` is **burst** by an arrow shot at `x` if
/// `x_start <= x <= x_end`.
/// There is **no limit** to the number of arrows that can be shot.
/// A shot arrow keeps traveling up infinitely, bursting any balloons in its
/// path.
///
/// Given the array `points`, return _the **minimum** number of arrows that must
/// be shot to burst all balloons_.
func findMinArrowShots(_ points: [[Int]]) -> Int {
	var count = 1
	let sorted = points.sorted { $0[0] < $1[0] }
	var previous = sorted[0]

	for point in sorted[1...] {
		let intersection = [
			max(previous[0], point[0]),
			min(previous[1], point[1])
		]

		if intersection[0] <= intersection[1] {
			previous = intersection
		} else {
			count += 1
			previous = point
		}
	}

	return count
}
