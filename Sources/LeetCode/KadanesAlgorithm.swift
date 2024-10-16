/// Maximum subarray
///
/// Given an integer array `nums`, find the subarray with the largest sum, and
/// return _its sum_.
func maxSubArray(_ nums: [Int]) -> Int {
	var sum = nums[0]
	var maxSum = sum

	for num in nums[1...] {
		sum = sum > 0 ? sum + num : num
		maxSum = sum > maxSum ? sum : maxSum
	}

	return maxSum
}

/// Maximum sum circular subarray
///
/// Given a **circular integer array** `nums` of length `n`, return _the maximum
/// possible sum of a non-empty **subarray** of `nums`_.
///
/// A **circular array** means the end of the array connects to the beginning of
/// the array. Formally, the next element of `nums[i]` is `nums[(i + 1) % n]`
/// and the previous element of `nums[i]` is `nums[(i - 1 + n) % n]`.
///
/// A **subarray** may only include each element of the fixed buffer `nums` at
/// most once. Formally, for a subarray `nums[i], nums[i + 1], ..., nums[j]`,
/// there does not exist `i <= k1, k2 <= j` with `k1 % n == k2 % n`.
func maxSubarraySumCircular(_ nums: [Int]) -> Int {
	var upperSum = nums[0], lowerSum = nums[0], totalSum = nums[0]
	var maxSum = upperSum, minSum = lowerSum

	for num in nums[1...] {
		totalSum += num
		upperSum = upperSum > 0 ? upperSum + num : num
		lowerSum = lowerSum < 0 ? lowerSum + num : num
		maxSum = upperSum > maxSum ? upperSum : maxSum
		minSum = lowerSum < minSum ? lowerSum : minSum
	}

	let remainder = totalSum - minSum
	if remainder > maxSum, remainder > 0 {
		maxSum = remainder
	}

	return maxSum
}
