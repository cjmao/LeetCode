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
	let n = gas.count
	var tank = 0
	var start = 0

	for i in 0 ..< 2 * n {
		tank += gas[i % n] - cost[i % n]
		if tank < 0 {
			tank = 0
			start = i + 1
		} else if i == start + n {
			break
		}
	}

	return start < n ? start : -1
}

/// Candy
///
/// There are `n` children standing in a line. Each child is assigned a rating
/// value given in the integer array `ratings`.
///
/// You are giving candies to these children subjected to the following
/// requirements:
///
/// - Each child must have at least one candy.
/// - Children with a higher rating get more candies than their neighbors.
///
/// Return *the minimum number of candies you need to have to distribute the
/// candies to the children*.
func candy(_ ratings: [Int]) -> Int {
	let n = ratings.count
	var extra = 0
	var upWidth = 0, downWidth = 0

	for (i, (a, b)) in zip(ratings, ratings[1...]).enumerated() {
		if a < b {
			if downWidth > 0 {
				extra -= min(upWidth, downWidth)
				upWidth = 0
				downWidth = 0
			}
			upWidth += 1
			extra += upWidth
		} else if a > b {
			downWidth += 1
			extra += downWidth
		}

		if a == b || i == n - 2 {
			extra -= min(upWidth, downWidth)
			upWidth = 0
			downWidth = 0
		}
	}

	return n + extra
}

/// Trapping rain water
///
/// Given `n` non-negative integers representing an elevation map where the
/// width of each bar is `1`, compute how much water it can trap after raining.
func trap(_ height: [Int]) -> Int {
	var trappedWater = 0
	var i = 0, j = height.endIndex - 1
	var maxHeight = (left: 0, right: 0)

	while i < j {
		let left = height[i]
		let right = height[j]

		if left <= right {
			maxHeight.left = max(left, maxHeight.left)
			trappedWater += maxHeight.left - left
			i += 1
		} else {
			maxHeight.right = max(right, maxHeight.right)
			trappedWater += maxHeight.right - right
			j -= 1
		}
	}

	return trappedWater
}

/// Roman to Integer
///
/// Roman numerals are represented by seven different symbols: `I`, `V`, `X`,
/// `L`, `C`, `D` and `M`.
///
/// | Symbol | Value |
/// |:------:|------:|
/// |   I    |     1 |
/// |   V    |     5 |
/// |   X    |    10 |
/// |   L    |    50 |
/// |   C    |   100 |
/// |   D    |   500 |
/// |   M    |  1000 |
///
/// For example, `2` is written as `II` in Roman numeral, just two ones added
/// together. `12` is written as `XII`, which is simply `X + II`. The number
/// `27` is written as `XXVII`, which is `XX + V + II`.
///
/// Roman numerals are usually written largest to smallest from left to right.
/// However, the numeral for four is not `IIII`. Instead, the number four is
/// written as `IV`. Because the one is before the five we subtract it making
/// four. The same principle applies to the number nine, which is written as
/// `IX`. There are six instances where subtraction is used:
///
/// - `I` can be placed before `V` (5) and `X` (10) to make 4 and 9.
/// - `X` can be placed before `L` (50) and `C` (100) to make 40 and 90.
/// - `C` can be placed before `D` (500) and `M` (1000) to make 400 and 900.
///
/// Given a roman numeral, convert it to an integer.
func romanToInt(_ s: String) -> Int {
	let values: [Character: _] = [
		"I": 1, "V": 5, "X": 10,
		"L": 50, "C": 100, "D": 500, "M": 1000
	]
	var number = 0
	var previous = Character("\0")

	for c in s {
		var value = values[c] ?? 0
		switch previous {
			case "I" where ["V", "X"].contains(c): fallthrough
			case "X" where ["L", "C"].contains(c): fallthrough
			case "C" where ["D", "M"].contains(c): value -= 2 * (values[previous] ?? 0)
			default: break
		}
		number += value
		previous = c
	}

	return number
}

/// Integer to Roman
/// Seven different symbols represent Roman numerals with the following values:
///
/// | Symbol | Value |
/// |:------:|------:|
/// |   I    |     1 |
/// |   V    |     5 |
/// |   X    |    10 |
/// |   L    |    50 |
/// |   C    |   100 |
/// |   D    |   500 |
/// |   M    |  1000 |
///
/// Roman numerals are formed by appending the conversions of decimal place
/// values from highest to lowest. Converting a decimal place value into a Roman
/// numeral has the following rules:
///
/// - If the value does not start with 4 or 9, select the symbol of the maximal
///   value that can be subtracted from the input, append that symbol to the
///   result, subtract its value, and convert the remainder to a Roman numeral.
///
/// - If the value starts with 4 or 9 use the **subtractive form** representing
///   one symbol subtracted from the following symbol, for example, 4 is 1 (`I`)
///   less than 5 (`V`): `IV` and 9 is 1 (`I`) less than 10 (`X`): `IX`. Only
///   the following subtractive forms are used: 4 (`IV`), 9 (`IX`), 40 (`XL`),
///   90 (`XC`), 400 (`CD`) and 900 (`CM`).
///
/// - Only powers of 10 (`I`, `X`, `C`, `M`) can be appended consecutively at
///   most 3 times to represent multiples of 10. You cannot append 5 (`V`), 50
///   (`L`), or 500 (`D`) multiple times. If you need to append a symbol 4 times
///   use the **subtractive form**.
///
/// Given an integer, convert it to a Roman numeral.
func intToRoman(_ num: Int) -> String {
	let literals = [
		"M", "CM", "D", "CD",
		"C", "XC", "L", "XL",
		"X", "IX", "V", "IV",
		"I"
	]
	let values = [
		1000, 900, 500, 400,
		100,  90,  50,  40,
		10,   9,   5,   4,
		1
	]

	var s = "", p = num

	for (literal, value) in zip(literals, values) {
		let (q, r) = p.quotientAndRemainder(dividingBy: value)
		s += [_](repeating: literal, count: q).joined()
		p = r
	}

	return s
}

/// Length of last word
///
/// Given a string `s` consisting of words and spaces, return *the length of the
/// last word in the string*.
///
/// A word is a maximal substring consisting of non-space characters only.
func lengthOfLastWord(_ s: String) -> Int {
	var length = 0

	for c in s.reversed() {
		if !c.isWhitespace {
			length += 1
		} else if length > 0 {
			break
		}
	}

	return length
}

/// Longest common prefix
///
/// Write a function to find the longest common prefix string amongst an array
/// of strings.
///
/// If there is no common prefix, return an empty string `""`.
func longestCommonPrefix(_ strs: [String]) -> String {
	let prefix = strs[0]
	var end = prefix.endIndex

	for s in strs[1...] {
		if s.isEmpty {
			return ""
		}
		end = min(end, s.endIndex)
		for i in s.indices {
			if i >= end || s[i] != prefix[i] {
				end = i
				break
			}
		}
	}

	return String(prefix[..<end])
}

/// Reverse words in a string
///
/// Given an input string `s`, reverse the order of the **words**.
///
/// A **word** is defined as a sequence of non-space characters. The **words**
/// in `s` will be separated by at least one space.
///
/// Return *a string of the words in reverse order concatenated by a single
/// space*.
///
/// **Note** that `s` may contain leading or trailing spaces or multiple spaces
/// between two words. The returned string should only have a single space
/// separating the words. Do not include any extra spaces.
func reverseWords(_ s: String) -> String {
	var reversed = ""
	var word = ""

	for c in (" " + s).reversed() {
		if c.isWhitespace {
			if !word.isEmpty {
				if !reversed.isEmpty {
					reversed.append(" ")
				}
				for c in word.reversed() {
					reversed.append(c)
				}
				word = ""
			}
		} else { // is letter
			word.append(c)
		}
	}

	return reversed
}

/// Zigzag conversion
///
/// The string `"PAYPALISHIRING"` is written in a zigzag pattern on a given
/// number of rows like this: (you may want to display this pattern in a fixed
/// font for better legibility)
///
/// ```
/// P   A   H   N
/// A P L S I I G
/// Y   I   R
/// ```
///
/// And then read line by line: `"PAHNAPLSIIGYIR"`
///
/// Write the code that will take a string and make this conversion given a
/// number of rows:
///
/// ```c
/// string convert(string s, int numRows);
/// ```
func convert(_ s: String, _ numRows: Int) -> String {
	var rows = [_](repeating: "", count: numRows)
	let period = max(1, numRows + (numRows - 2))

	for (i, c) in s.enumerated() {
		let t = i % period
		let row = t < numRows ? t : period - t
		rows[row].append(String(c))
	}

	return rows.joined()
}

/// Find the index of the first occurrence in a string
///
/// Given two strings `needle` and `haystack`, return the index of the first
/// occurrence of `needle` in `haystack`, or `-1` if `needle` is not part of
/// `haystack`.
func strStr(_ haystack: String, _ needle: String) -> Int {
	-1
}

/// Text justification
///
/// Given an array of strings `words` and a width `maxWidth`, format the text
/// such that each line has exactly `maxWidth` characters and is fully (left and
/// right) justified.
///
/// You should pack your words in a greedy approach; that is, pack as many words
/// as you can in each line. Pad extra spaces `' '` when necessary so that each
/// line has exactly `maxWidth` characters.
///
/// Extra spaces between words should be distributed as evenly as possible. If
/// the number of spaces on a line does not divide evenly between words, the
/// empty slots on the left will be assigned more spaces than the slots on the
/// right.
///
/// For the last line of text, it should be left-justified, and no extra space
/// is inserted between words.
///
/// **Note**:
///
/// - A word is defined as a character sequence consisting of non-space
///   characters only.
/// - Each word's length is guaranteed to be greater than `0` and not exceed
///   `maxWidth`.
/// - The input array `words` contains at least one word.
func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
	[]
}
