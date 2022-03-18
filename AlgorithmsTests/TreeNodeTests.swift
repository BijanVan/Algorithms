//
//  TreeNodeTests.swift
//  AlgorithmsTests
//
//  Created by Bijan Vancouver on 2022-03-01.
//

import XCTest

import Algorithms

class TreeNodeTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  private func makeBeverageTree() -> TreeNode<String> {
    let tree = TreeNode("Beverages")

    let hot = TreeNode("hot")
    let cold = TreeNode("cold")

    let tea = TreeNode("tea")
    let coffee = TreeNode("coffee")
    let chocolate = TreeNode("cocoa")

    let blackTea = TreeNode("black")
    let greenTea = TreeNode("green")
    let chaiTea = TreeNode("chai")

    let soda = TreeNode("soda")
    let milk = TreeNode("milk")

    let gingerAle = TreeNode("ginger ale")
    let bitterLemon = TreeNode("bitter lemon")

    tree.add(hot)
    tree.add(cold)

    hot.add(tea)
    hot.add(coffee)
    hot.add(chocolate)

    cold.add(soda)
    cold.add(milk)

    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)

    soda.add(gingerAle)
    soda.add(bitterLemon)

    return tree
  }

  func testForEachDepthFirst() {
    let tree = makeBeverageTree()
    tree.forEachDepthFirst { print($0.value) }
  }

  func testForEachLevelOrder() {
    let tree = makeBeverageTree()
    tree.forEachLevelOrder { print($0.value) }
  }

  func testSearch() {
    let tree = makeBeverageTree()
    XCTAssert(tree.search("ginger ale") != nil)
    XCTAssert(tree.search("gingar ala") == nil)
  }
}
