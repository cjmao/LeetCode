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
	false
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
	""
}

/// Min stack
///
/// Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
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
	init() {

	}

	func push(_ val: Int) {

	}

	func pop() {

	}

	func top() -> Int {
		0
	}

	func getMin() -> Int {
		0
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
	0
}

/// Basic calculator
///
/// Given a string `s` representing a valid expression, implement a basic
/// calculator to evaluate it, and return _the result of the evaluation_.
///
/// **Note**: You are not allowed to use any built-in function which evaluates
/// strings as mathematical expressions, such as eval().
func calculate(_ s: String) -> Int {
	0
}
