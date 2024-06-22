/// Merge sorted arrays.
///
/// You are given two integer arrays `nums1` and `nums2`, sorted in
/// **non-decreasing order**, and two integers `m` and `n`, representing the
/// number of elements in `nums1` and `nums2` respectively.
///
/// Merge `nums1` and `nums2` into a single array sorted in
/// **non-decreasing order**.
///
/// The final sorted array should not be returned by the function, but instead
/// be stored inside the array `nums1`. To accommodate this, `nums1` has a
/// length of `m + n`, where the first `m` elements denote the elements that
/// should be merged, and the last `n` elements are set to `0` and should be
/// ignored. `nums2` has a length of `n`.
func mergeSortedArrays(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
	var (i, j) = (m - 1, n - 1)
	for k in nums1.indices.reversed() {
		if j < 0 { break }
		if i < 0 {
			nums1[k] = nums2[j]
			j -= 1
			continue
		}
		let (n1, n2) = (nums1[i], nums2[j])
		if n1 > n2 {
			nums1[k] = n1
			i -= 1
		} else { // n1 <= n2
			nums1[k] = n2
			j -= 1
		}
	}
}

/// Remove element
///
/// Given an integer array `nums` and an integer `val`, remove all occurrences
/// of `val` in `nums` **in-place**. The order of the elements may be changed.
/// Then return *the number of elements in `nums` which are not equal to `val`*.
///
/// Consider the number of elements in `nums` which are not equal to `val` be
/// `k`, to get accepted, you need to do the following things:
///
/// - Change the array `nums` such that the first `k` elements of `nums` contain
///   the elements which are not equal to `val`. The remaining elements of `nums`
///   are not important as well as the size of `nums`.
/// - Return `k`.
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
	var k = 0
	for i in nums.indices {
		if nums[i] != val {
			nums[k] = nums[i]
			k += 1
		}
	}
	return k
}

/// Remove duplicates from sorted array.
///
/// Given an integer array `nums` sorted in **non-decreasing order**, remove the
/// duplicates `in-place` such that each unique element appears only **once**.
/// The relative order of the elements should be kept the **same**. Then return
/// *the number of unique elements in `nums`*.
///
/// Consider the number of unique elements of `nums` to be `k`, to get accepted,
/// you need to do the following things:
///
/// - Change the array `nums` such that the first `k` elements of `nums` contain
///   the unique elements in the order they were present in `nums` initially.
///   The remaining elements of `nums` are not important as well as the size of
///   `nums`.
/// - Return `k`.
func removeDuplicates(_ nums: inout [Int]) -> Int {
	if nums.isEmpty {
		return 0
	}

	var k = 0

	for i in nums[1...].indices {
		let last = nums[k]
		let current = nums[i]

		if current != last {
			k += 1
			nums[k] = current
		}
	}

	return k + 1
}

/// Remove duplicates from sorted array II.
///
/// Given an integer array `nums` sorted in **non-decreasing order**, remove
/// some duplicates **in-place** such that each unique element appears at most
/// twice. The relative order of the elements should be kept the same.
///
/// Since it is impossible to change the length of the array in some languages,
/// you must instead have the result be placed in the **first part** of the
/// array `nums`. More formally, if there are `k` elements after removing the
/// duplicates, then the first `k` elements of `nums` should hold the final
/// result. It does not matter what you leave beyond the first `k` elements.
///
/// Return `k` *after placing the final result in the first `k` slots of `nums`*.
///
/// Do **not** allocate extra space for another array. You must do this by
/// **modifying the input array in-place** with `O(1)` extra memory.
func removeDuplicatesWhileKeepingAtMostTwo(_ nums: inout [Int]) -> Int {
	if nums.count < 3 {
		return nums.count
	}

	var k = 1

	for i in nums[2...].indices {
		let previous = nums[k - 1]
		let current = nums[k]
		let next = nums[i]

		if previous != current || current != next {
			k += 1
			nums[k] = next
		}
	}

	return k + 1
}

/// Majority element.
///
/// Given an array `nums` of size `n`, return *the majority element*.
///
/// The majority element is the element that appears more than `⌊n / 2⌋` times.
/// You may assume that the majority element always exists in the array.
func majorityElement(_ nums: [Int]) -> Int {
	var k = nums[0]
	var count = 1

	for num in nums[1...] {
		count += num == k ? 1 : -1
		if count == 0 {
			k = num
			count = 1
		}
	}

	return k
}

/// Rotate array.
///
/// Given an integer array `nums`, rotate the array to the right by `k` steps,
/// where `k` is non-negative.
func rotate(_ nums: inout [Int], _ k: Int) {
	let k = k % nums.count
	if k == 0 {
		return
	}

	let n = nums.endIndex

	// reverse the whole array
	for i in 0..<(n / 2) {
		let j = (n - 1) - i
		(nums[i], nums[j]) = (nums[j], nums[i])
	}

	// reverse the first k elements
	for i in 0..<(k / 2) {
		let j = (k - 1) - i
		(nums[i], nums[j]) = (nums[j], nums[i])
	}

	// reverse the last n - k elements
	for i in k..<((n + k) / 2) {
		let j = (n - 1) - (i - k)
		(nums[i], nums[j]) = (nums[j], nums[i])
	}
}

/// Best time to buy and sell stock.
///
/// You are given an array `prices` where `prices[i]` is the price of a given
/// stock on the `ith` day.
///
/// You want to maximize your profit by choosing **a single day** to buy one
/// stock and choosing **a different day in the future** to sell that stock.
///
/// Return *the maximum profit you can achieve from this transaction*.
/// If you cannot achieve any profit, return `0`.
func maxProfit(_ prices: [Int]) -> Int {
	0
}

/// Best time to buy and sell stock II.
///
/// You are given an integer array `prices` where `prices[i]` is the price of a
/// given stock on the `ith` day.
///
/// On each day, you may decide to buy and/or sell the stock. You can only hold
/// **at most one** share of the stock at any time. However, you can buy it then
/// immediately sell it on the **same day**.
///
/// Find and return *the **maximum** profit you can achieve*.
func maxProfitAllowingSellingOnSameDay(_ prices: [Int]) -> Int {
	0
}
