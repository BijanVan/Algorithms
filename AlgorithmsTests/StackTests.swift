//
//  StackTests.swift
//  StackTests
//
//  Created by Bijan Vancouver on 2022-02-14.
//

import XCTest
@testable import Algorithms

class StackTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testFILO() {
    var stack = Stack<Int>()
    XCTAssert(stack.isEmpty())

    stack.push(1)
    stack.push(2)
    stack.push(3)

    XCTAssert(!stack.isEmpty())
    XCTAssert(stack.pop() == 3)
    XCTAssert(stack.pop() == 2)
    XCTAssert(stack.pop() == 1)
    XCTAssert(stack.isEmpty())
  }

  func testPeek() {
    var stack = Stack<Int>()
    stack.push(1)
    XCTAssert(stack.peek() == 1)
    XCTAssert(!stack.isEmpty())
  }

  func testFromArrayLiterals() {
    var stack: Stack<Int> = [1, 2, 3]
    XCTAssert(stack.pop() == 3)
    XCTAssert(stack.pop() == 2)
    XCTAssert(stack.pop() == 1)
  }

  func testReverseArray() {
    let arr = [1, 2, 3]
    var stack = Stack<Int>(arr)
    var reversed: [Int] = []
    while let elem = stack.pop() {
      reversed.append(elem)
    }

    XCTAssert(reversed == arr.reversed())
  }

  private func isParenthesesBalanced(in string: String) -> Bool {
    guard !string.isEmpty else {
      return true
    }

    var parentheses = Stack<Character>()
    for char in string {
      if char == "(" {
        parentheses.push(char)
      } else if (char == ")") {
        parentheses.pop()
      }
    }

    return parentheses.isEmpty()
  }

  func testIsParenthesesBalanced() {
    var testString = "h((e))llo(world)()"
    XCTAssert(isParenthesesBalanced(in: testString))

    testString = "(hello world"
    XCTAssert(!isParenthesesBalanced(in: testString))
  }
}
