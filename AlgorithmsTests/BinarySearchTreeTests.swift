//
//  BinarySearchTreeTests.swift
//  AlgorithmsTests
//
//  Created by Bijan Vancouver on 2022-03-09.
//

import XCTest

import Algorithms

class BinarySearchTreeTests: XCTestCase {
  private var tree: BinarySearchTree<Int> = {
    var bst = BinarySearchTree<Int>()
    bst.insert(30)
    bst.insert(10)
    bst.insert(40)
    bst.insert(0)
    bst.insert(20)
    bst.insert(50)
    bst.insert(33)
    bst.insert(22)
    bst.insert(11)
    XCTAssert(bst.isValid)
    return bst
  }()
  
  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {}
  
  func testExample() {
    var bst = BinarySearchTree<Int>()
    for val in 0..<5 {
      bst.insert(val)
    }
    XCTAssert(bst.isValid)
  }
  
  func testContains() {
    XCTAssert(tree.contains(0))
    XCTAssert(!tree.contains(100))
    print(tree)
  }
  
  func testRemoveLeaf() {
    XCTAssert(tree.remove(50))
    XCTAssert(tree.isValid)
    XCTAssert(!tree.contains(50))
  }
  
  func testRemoveNodeWithRightChild() {
    XCTAssert(tree.remove(40))
    XCTAssert(tree.isValid)
    XCTAssert(!tree.contains(40))
  }
  
  func testRemoveRoot() {
    XCTAssert(tree.remove(30))
    XCTAssert(tree.isValid)
    XCTAssert(!tree.contains(30))
  }

  func testRemoveFullNode() {
    XCTAssert(tree.remove(20))
    XCTAssert(tree.isValid)
    XCTAssert(!tree.contains(20))
  }

  func testEquatable() {
    var tree1 = BinarySearchTree<Int>()
    tree1.insert(30)
    tree1.insert(10)
    tree1.insert(40)
    tree1.insert(0)
    tree1.insert(20)
    tree1.insert(50)
    tree1.insert(33)
    tree1.insert(22)
    tree1.insert(11)

    XCTAssertEqual(tree, tree1)
  }
}
