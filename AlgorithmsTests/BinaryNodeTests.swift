//
//  BinaryNodeTests.swift
//  AlgorithmsTests
//
//  Created by Bijan Vancouver on 2022-03-03.
//

import XCTest

import Algorithms

class BinaryNodeTests: XCTestCase {
  let tree1: BinaryNode<Int> = {
    let zero = BinaryNode(0)
    let two = BinaryNode(2)
    let five = BinaryNode(5)
    let seven = BinaryNode(7)
    let eight = BinaryNode(8)
    let nine = BinaryNode(9)

    let one = BinaryNode(1)
    zero.rightChild = one

    seven.leftChild = two
    two.leftChild = zero
    two.rightChild = five
    seven.rightChild = nine
    nine.leftChild = eight

    return seven
  }()

  let tree2: BinaryNode<Int> = {
    let root = BinaryNode(15)
    let ten = BinaryNode(10)
    let five = BinaryNode(5)
    let twelve = BinaryNode(12)
    let twentyFive = BinaryNode(25)
    let seventeen = BinaryNode(17)

    root.leftChild = ten
    root.rightChild = twentyFive
    ten.leftChild = five
    ten.rightChild = twelve
    twentyFive.leftChild = seventeen

    return root
  }()

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testDiagram() {
    let expected = """
┌───9
│   └───8
7
│   ┌───5
└───2
    │   ┌───1
    └───0
"""
    XCTAssert(expected == "\(tree1)".trimmingCharacters(in: .whitespacesAndNewlines))
  }

  func testTraverseInOrder() {
    var result = ""
    tree1.traverseInOrder { result.append("\($0)") }
    XCTAssert(result == "0125789")
  }

  func testTraversePreOrder() {
    var result = ""
    tree1.traversePreOrder { result.append("\($0)") }
    XCTAssert(result == "7201598")
  }

  func testTraversePostOrder() {
    var result = ""
    tree1.traversePostOrder { result.append("\($0)") }
    XCTAssert(result == "1052897")
  }

  func height<T>(of node: BinaryNode<T>?) -> Int {
    guard let node = node else {
      return -1
    }
    return 1 + max(height(of: node.leftChild), height(of: node.rightChild))
  }
  
  func testHeight() {
    XCTAssertEqual(height(of: tree1), 3)
  }

  func testSerialize() {
    XCTAssertEqual(tree2.serialize(), [15, 10, 5, nil, nil, 12, nil, nil, 25, 17, nil, nil, nil])
  }

  func testDeserialize() {
    let elements = [15, 10, 5, nil, nil, 12, nil, nil, 25, 17, nil, nil, nil]
    let tree = BinaryNode.deserialize(elements)
    XCTAssertEqual(tree?.serialize(), elements)
  }
}
