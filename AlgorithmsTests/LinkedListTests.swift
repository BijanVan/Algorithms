//
//  LinkedListTests.swift
//  AlgorithmsTests
//
//  Created by Bijan Vancouver on 2022-02-15.
//

import XCTest
import Algorithms

class LinkedListTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testNodeToString() {
    let node1 = Node(1)
    let node2 = Node(2)
    let node3 = Node(3)
    node1.next = node2
    node2.next = node3

    XCTAssert("\(node1)".trimmingCharacters(in: .whitespacesAndNewlines) == "1 -> 2 -> 3")
  }

  func testPush() {
    var list = LinkedList<Int>()
    list.push(2)
    list.push(1)
    list.push(0)

    XCTAssert("\(list)".trimmingCharacters(in: .whitespacesAndNewlines) == "0 -> 1 -> 2")
  }

  func testNodeAt() {
    var list = LinkedList<Int>()
    XCTAssert(list.node(at: 0) === nil)

    list.push(2)
    list.push(1)
    list.push(0)

    XCTAssert(!list.isEmpty)
    XCTAssert(list.node(at: 0)?.value == 0)
    XCTAssert(list.node(at: 1)?.value == 1)
    XCTAssert(list.node(at: 2)?.value == 2)
    XCTAssert(list.node(at: 100) == nil)
  }

  func testInsert() {
    var list = LinkedList<Int>()

    list.push(2)
    list.push(1)
    list.push(0)

    let midNode = list.node(at: 1)!
    list.insert(-1, after: midNode)
    XCTAssert("\(list)".trimmingCharacters(in: .whitespacesAndNewlines) == "0 -> 1 -> -1 -> 2")
  }

  func testPop() {
    var list = LinkedList<Int>()
    list.push(0)
    list.pop()
    XCTAssert(list.isEmpty)

    list.push(2)
    list.push(1)
    list.push(0)

    list.pop()
    XCTAssert("\(list)".trimmingCharacters(in: .whitespacesAndNewlines) == "1 -> 2")
  }

  func testRemoveLast() {
    var list = LinkedList<Int>()
    list.push(0)
    list.removeLast()
    XCTAssert(list.isEmpty)

    list.push(2)
    list.push(1)
    list.push(0)

    list.removeLast()
    XCTAssert("\(list)".trimmingCharacters(in: .whitespacesAndNewlines) == "0 -> 1")
  }

  func testCollection() {
    var list = LinkedList<Int>()
    for value in 0 ... 9 {
      list.push(value)
    }

    XCTAssert(list[list.startIndex] == 9)
    XCTAssert(Array(list.prefix(3)) == [9, 8, 7])
    XCTAssert(Array(list.suffix(3)) == [2, 1, 0])
    XCTAssert(list.reduce(0, +) == 45)
    list.removeLast()
    XCTAssert(Array(list.suffix(3)) == [3, 2, 1])
  }

  func testImmutability() {
    var list1 = LinkedList<Int>()

    list1.push(3)
    list1.push(2)
    list1.push(1)
    var list2 = list1

    XCTAssert("\(list1)" == "\(list2)")

    list2.push(0)

    XCTAssert("\(list1)".trimmingCharacters(in: .whitespacesAndNewlines) == "1 -> 2 -> 3")
    XCTAssert("\(list2)".trimmingCharacters(in: .whitespacesAndNewlines) == "0 -> 1 -> 2 -> 3")

    if let node = list2.node(at: 0) {
      list2.remove(after: node)
    }
    XCTAssert("\(list2)".trimmingCharacters(in: .whitespacesAndNewlines) == "0 -> 2 -> 3")
  }

  private func reversed<T>(_ list: LinkedList<T>) -> LinkedList<T> {
    var result = LinkedList<T>()
    var index = 0
    while let node = list.node(at: index) {
      result.push(node.value)
      index += 1
    }

    return result
  }

  func testReversed() {
    var list1 = LinkedList<Int>()

    list1.push(3)
    list1.push(2)
    list1.push(1)

    let list2 = reversed(list1)
    XCTAssert("\(list2)".trimmingCharacters(in: .whitespacesAndNewlines) == "3 -> 2 -> 1")
  }

  private func middleNode<T>(of list: LinkedList<T>) -> Node<T>? {
    var counter = 0
    var node = list.node(at: 0)
    while node !== nil {
      counter += 1
      node = list.node(at: counter)
    }
    return list.node(at: counter / 2)
  }

  func testMiddleNode() {
    var list = LinkedList<Int>()

    list.push(3)
    list.push(2)
    list.push(1)

    XCTAssert(middleNode(of: list)?.value == 2)
  }

  func testAppend() {
    var list1 = LinkedList<Int>()

    list1.push(2)
    list1.push(1)

    var list2 = LinkedList<Int>()

    list2.push(4)
    list2.push(3)

    list1.append(list2)
    XCTAssert("\(list1)".trimmingCharacters(in: .whitespacesAndNewlines) == "1 -> 2 -> 3 -> 4")

    list1.append(5)
    XCTAssert("\(list1)".trimmingCharacters(in: .whitespacesAndNewlines) == "1 -> 2 -> 3 -> 4 -> 5")
    XCTAssert("\(list2)".trimmingCharacters(in: .whitespacesAndNewlines) == "3 -> 4")
  }

  func testRemoveAll() {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    list.push(0)
    list.push(0)

    list.removeAll(0)
    print("\(list)")
    XCTAssert("\(list)".trimmingCharacters(in: .whitespacesAndNewlines) == "1 -> 2 -> 3")
  }
}
