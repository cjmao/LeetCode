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
	var maxSum = 0
	var currentSum = 0

	for i in prices[1...].indices {
		let diff = prices[i] - prices[i - 1]
		currentSum = max(0, currentSum + diff)
		if currentSum > maxSum {
			maxSum = currentSum
		}
	}

	return maxSum
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
	var sum = 0

	for i in prices[1...].indices {
		let diff = prices[i] - prices[i - 1]
		sum += max(0, diff)
	}

	return sum
}

/// Jump game.
///
/// You are given an integer array `nums`. You are initially positioned at the
/// array's **first index**, and each element in the array represents your
/// maximum jump length at that position.
///
/// Return *`true` if you can reach the last index, or `false` otherwise*.
func canJump(_ nums: [Int]) -> Bool {
	if nums.count < 2 {
		return true
	}

	var steps = 0

	for num in nums[1...].reversed() {
		steps = steps <= num ? 1 : steps + 1
	}

	return steps <= nums[0]
}

/// Jump game II.
///
/// You are given a **0-indexed** array of integers `nums` of length `n`. You
/// are initially positioned at `nums[0]`.
///
/// Each element `nums[i]` represents the maximum length of a forward jump from
/// index `i`. In other words, if you are at `nums[i]`, you can jump to any
/// `nums[i + j]` where:
///
/// - `0 <= j <= nums[i]` and
/// - `i + j < n`
///
/// Return *the minimum number of jumps to reach `nums[n - 1]`. The test cases
/// are generated such that you can reach `nums[n - 1]`*.
func jump(_ nums: [Int]) -> Int {
	var steps = 0
	var endOfCurrentStep = 0
	var endOfNextStep = 0

	for (i, step) in nums[0..<nums.endIndex - 1].enumerated() {
		endOfNextStep = max(endOfNextStep, i + step)
		if endOfNextStep >= nums.count - 1 {
			return 1 + steps
		} else if i == endOfCurrentStep {
			steps += 1
			endOfCurrentStep = endOfNextStep
		}
	}

	return steps
}

/// H-index.
///
/// Given an array of integers `citations` where `citations[i]` is the number
/// of citations a researcher received for their `ith` paper, return *the
/// researcher's `h-index`*.
///
/// According to the definition of `h-index` on Wikipedia: The `h-index` is
/// defined as the maximum value of `h` such that the given researcher has
/// published at least `h` papers that have each been cited at least `h` times.
///
/// **Constraints**:
/// - `n == citations.length`
/// - `1 <= n <= 5000`
/// - `0 <= citations[i] <= 1000`
func hIndex(_ citations: [Int]) -> Int {
	let n = citations.count
	var frequencies = [Int](repeating: 0, count: n + 1)

	for c in citations {
		frequencies[min(n, c)] += 1
	}

	var totalCount = 0

	for (timesCited, count) in frequencies.enumerated().reversed() {
		totalCount += count
		if totalCount >= timesCited {
			return timesCited
		}
	}

	return 0
}

/// Product of array except self.
///
/// Given an integer array `nums`, return *an array `answer` such that
/// `answer[i]` is equal to the product of all the elements of `nums` except
/// `nums[i]`*.
///
/// The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit
/// integer.
///
/// You must write an algorithm that runs in `O(n)` time and without using the
/// division operation.
func productExceptSelf(_ nums: [Int]) -> [Int] {
	if nums.count < 2 {
		return nums
	}

	var products = nums

	for i in products.indices {
		products[i] = if i == products.startIndex {
			1
		} else {
			nums[i - 1] * products[i - 1]
		}
	}

	var trailingProduct = 1
	for i in products.indices.reversed() {
		products[i] *= trailingProduct
		trailingProduct *= nums[i]
	}

	return products
}

/// Gas station.
///
/// There are `n` gas stations along a circular route, where the amount of gas
/// at the `ith` station is `gas[i]`.
///
/// You have a car with an unlimited gas tank and it costs `cost[i]` of gas to
/// travel from the `ith` station to its next `(i + 1)th` station. You begin the
/// journey with an empty tank at one of the gas stations.
///
/// Given two integer arrays `gas` and `cost`, return *the starting gas
/// station's index if you can travel around the circuit once in the clockwise
/// direction, otherwise return `-1`*. If there exists a solution, it is
/// **guaranteed** to be **unique**.
func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
	0
}
