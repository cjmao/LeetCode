/// Minimum size subarray sum
///
/// Given an array of positive integers `nums` and a positive integer `target`,
/// return _the **minimal length** of a subarray whose sum is greater than or
/// equal to `target`_. If there is no such subarray, return `0` instead.
func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
	var minCount = nums.count + 1
	var sum = 0
	var i = 0

	for (j, n) in nums.enumerated() {
		sum += n

		while sum >= target {
			minCount = min(j - i + 1, minCount)
			sum -= nums[i]
			i += 1
		}
	}

	return minCount > nums.count ? 0 : minCount
}
