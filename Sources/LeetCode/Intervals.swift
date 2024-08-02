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
	[]
}

/// Merge intervals
///
/// Given an array of `intervals` where `intervals[i] = [starti, endi]`, merge
/// all overlapping intervals, and return _an array of the non-overlapping
/// intervals that cover all the intervals in the input_.
func merge(_ intervals: [[Int]]) -> [[Int]] {
	[]
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
	[]
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
/// A shot arrow keeps traveling up infinitely, bursting any balloons in its path.
///
/// Given the array `points`, return _the **minimum** number of arrows that must be shot to burst all balloons_.
func findMinArrowShots(_ points: [[Int]]) -> Int {
	0
}
