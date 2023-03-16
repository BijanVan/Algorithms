//
//  BinaryNode.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-03-03.
//

import Foundation

public class BinaryNode<Element> {
  public var value: Element
  public var leftChild: BinaryNode?
  public var rightChild: BinaryNode?
  public var height = 0

  public var balanceFactor: Int {
    leftHeight - rightHeight
  }

  public var leftHeight: Int {
    leftChild?.height ?? -1
  }

  public var rightHeight: Int {
    rightChild?.height ?? -1
  }

  public init(_ value: Element) {
    self.value = value
  }
}

extension BinaryNode: CustomStringConvertible {
  private func diagram(_ top: String = "",
                       _ root: String = "", _ bottom: String = "") -> String {
    guard (leftChild != nil) || (rightChild != nil) else {
      return root + "\(value)\n"
    }

    let right = rightChild?.diagram(top + "    ", top + "┌───", top + "│   ") ?? ""
    let middle = root + "\(value),\(height)\n"
    let left = leftChild?.diagram(bottom + "│   ", bottom + "└───", bottom + "    ") ?? ""

    return right + middle + left
  }

  public var description: String {
    diagram()
  }
}

extension BinaryNode {
  public func traverseInOrder(visit: (Element) -> Void) {
    leftChild?.traverseInOrder(visit: visit)
    visit(value)
    rightChild?.traverseInOrder(visit: visit)
  }

  public func traversePreOrder(visit: (Element) -> Void) {
    visit(value)
    leftChild?.traversePreOrder(visit: visit)
    rightChild?.traversePreOrder(visit: visit)
  }

  public func traversePostOrder(visit: (Element) -> Void) {
    leftChild?.traversePostOrder(visit: visit)
    rightChild?.traversePostOrder(visit: visit)
    visit(value)
  }
}

extension BinaryNode {
  private func traversePreOrderNil(visit: (Element?) -> Void) {
    visit(value)
    
    if let leftChild = leftChild {
      leftChild.traversePreOrderNil(visit: visit)
    } else {
      visit(nil)
    }

    if let rightChild = rightChild {
      rightChild.traversePreOrderNil(visit: visit)
    } else {
      visit(nil)
    }
  }

  public func serialize() -> [Element?] {
    var serialized: [Element?] = []
    traversePreOrderNil {
      serialized.append($0)
    }

    return serialized
  }

  public static func deserialize(_ elements: [Element?]) -> BinaryNode? {
    var stack: [BinaryNode] = []
    var root: BinaryNode?
    var parent: BinaryNode?
    var last: BinaryNode?

    for elem in elements {
      if let elem = elem {
        let node = BinaryNode(elem)
        root = root ?? node
        if let last = last {
          last.rightChild = node
        } else {
          parent?.leftChild = node
        }
        stack.append(node)
        parent = node
        last = nil
      } else {
        last = stack.popLast()
      }
    }

    return root
  }
}

extension BinaryNode: Equatable where Element: Equatable {
  public static func == (lhs: BinaryNode<Element>, rhs: BinaryNode<Element>) -> Bool {
    lhs.value == rhs.value && lhs.leftChild == rhs.leftChild && lhs.rightChild == rhs.rightChild
  }
}
