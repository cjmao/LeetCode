/// Valid parentheses
///
/// Given a string `s` containing just the characters `'('`, `')'`, `'{'`,
/// `'}'`, `'['` and `']'`, determine if the input string is valid.
///
/// An input string is valid if:
///
/// - Open brackets must be closed by the same type of brackets.
/// - Open brackets must be closed in the correct order.
/// - Every close bracket has a corresponding open bracket of the same type.
func isValid(_ s: String) -> Bool {
	var stack = [Character]()

	for c in s {
		let last = stack.last
		if c == ")", last == "(" {
			stack.removeLast()
		} else if c == "}", last == "{" {
			stack.removeLast()
		} else if c == "]", last == "[" {
			stack.removeLast()
		} else {
			stack.append(c)
		}
	}

	return stack.isEmpty
}

/// Simplify path
///
/// Given an absolute path for a Unix-style file system, which begins with a slash `'/'`, transform this path into its **simplified canonical path**.
///
/// In Unix-style file system context, a single period `'.'` signifies the
/// current directory, a double period `".."` denotes moving up one directory
/// level, and multiple slashes such as `"//"` are interpreted as a single
/// slash. In this problem, treat sequences of periods not covered by the
/// previous rules (like `"..."`) as valid names for files or directories.
///
/// The simplified canonical path should adhere to the following rules:
///
/// - It must start with a single slash `'/'`.
/// - Directories within the path should be separated by only one slash `'/'`.
/// - It should not end with a slash `'/'`, unless it's the root directory.
/// - It should exclude any single or double periods used to denote current or
///   parent directories.
///
/// Return the new path.
func simplifyPath(_ path: String) -> String {
	var components = [Substring]()
	let splitPath = path.split(separator: "/")

	for component in splitPath {
		if component == "" || component == "." {
			continue
		} else if component == ".." {
			if !components.isEmpty {
				components.removeLast()
			}
		} else {
			components.append(component)
		}
	}

	return "/" + components.joined(separator: "/")
}

/// Min stack
///
/// Design a stack that supports push, pop, top, and retrieving the minimum
/// element in constant time.
///
/// Implement the `MinStack` class:
///
/// - `MinStack()` initializes the stack object.
/// - `void push(int val)` pushes the element `val` onto the stack.
/// - `void pop()` removes the element on the top of the stack.
/// - `int top()` gets the top element of the stack.
/// - `int getMin()` retrieves the minimum element in the stack.
///
/// You must implement a solution with `O(1)` time complexity for each function.
class MinStack {
	private var elements = [Int]()
	private var minValues = [Int]()

	init() {}

	func push(_ val: Int) {
		elements.append(val)
		minValues.append(min(minValues.last ?? val, val))
	}

	func pop() {
		_ = elements.popLast()
		_ = minValues.popLast()
	}

	func top() -> Int {
		elements.last ?? Int.max
	}

	func getMin() -> Int {
		minValues.last ?? Int.max
	}
}

/// Evaluate reverse polish notation
///
/// You are given an array of strings `tokens` that represents an arithmetic
/// expression in a Reverse Polish Notation.
///
/// Evaluate the expression. Return _an integer that represents the value of the
/// expression_.
///
/// **Note** that:
///
/// - The valid operators are `'+'`, `'-'`, `'*'`, and `'/'`.
/// - Each operand may be an integer or another expression.
/// - The division between two integers always truncates toward zero.
/// - There will not be any division by zero.
/// - The input represents a valid arithmetic expression in a reverse polish
///   notation.
/// - The answer and all the intermediate calculations can be represented in a
///   `32-bit` integer.
func evalRPN(_ tokens: [String]) -> Int {
	var numbers = [Int]()

	for token in tokens {
		if let number = Int(token) {
			numbers.append(number)
			continue
		}

		let operation: ((Int, Int) -> Int)? = switch token {
			case "+": (+)
			case "-": (-)
			case "*": (*)
			case "/": (/)
			default: nil
		}

		if let operation {
			let (b, a) = (
				numbers.removeLast(),
				numbers.last!
			)
			let result = operation(a, b)
			numbers[numbers.endIndex - 1] = result
		}
	}

	return numbers.last!
}

/// Basic calculator
///
/// Given a string `s` representing a valid expression, implement a basic
/// calculator to evaluate it, and return _the result of the evaluation_.
///
/// **Note**: You are not allowed to use any built-in function which evaluates
/// strings as mathematical expressions, such as eval().
func calculate(_ s: String) -> Int {
	var result = 0

	var stack = [Int]()
	var operand: Int?
	var sign = 1

	for c in s {
		if let digit = c.wholeNumberValue {
			operand = (operand ?? 0) * 10 + digit
			continue
		}

		if c == "+" {
			result += sign * (operand ?? 0)
			operand = nil
			sign = 1
		} else if c == "-" {
			result += sign * (operand ?? 0)
			operand = nil
			sign = -1
		} else if c == "(" {
			stack.append(result)
			stack.append(sign)
			result = 0
			operand = nil
			sign = 1
		} else if c == ")" {
			result += sign * (operand ?? 0)
			operand = nil
			sign = stack.removeLast()
			result = stack.removeLast() + sign * result
		}
	}

	result += sign * (operand ?? 0)

	return result
}
