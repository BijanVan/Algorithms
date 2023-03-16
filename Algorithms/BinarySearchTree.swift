//
//  BinarySearchTree.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-03-09.
//

import Foundation

public struct BinarySearchTree<Element: Comparable> {
  private(set) var root: BinaryNode<Element>?
  
  public init() {}

  public mutating func insert(_ value: Element) {
    guard root != nil else {
      root = BinaryNode(value)
      return
    }
    var node = root
    var stack: [BinaryNode<Element>] = []

    while let iterNode = node {
      stack.append(iterNode)
      if value < iterNode.value {
        node = iterNode.leftChild
        iterNode.leftChild = node ?? BinaryNode(value)
      } else {
        node = iterNode.rightChild
        iterNode.rightChild = node ?? BinaryNode(value)
      }
    }

    while let node = stack.popLast() {
      node.height = max(node.leftHeight, node.rightHeight) + 1
      if let last = stack.last {
        if last.rightChild != nil {
          last.rightChild = balanced(node)
        } else {
          last.leftChild = balanced(node)
        }
      } else {
        root = balanced(node)
      }
    }
  }

  public func contains(_ value: Element) -> Bool {
    var node = root

    while let iterNode = node {
      if iterNode.value == value {
        return true
      } else if value < iterNode.value {
        node = iterNode.leftChild
      } else {
        node = iterNode.rightChild
      }
    }

    return false
  }

  // Balancing not implemented
  public mutating func remove(_ value: Element) -> Bool {
    var node = root
    var parent: BinaryNode<Element>?

    while let iterNode = node {
      if iterNode.value == value {
        remove(&node!, from: &parent)
        return true
      } else if value < iterNode.value {
        parent = node
        node = iterNode.leftChild
      } else {
        parent = node
        node = iterNode.rightChild
      }
    }

    return false
  }

  private mutating func remove(_ node: inout BinaryNode<Element>, from parent: inout BinaryNode<Element>?) {
    // case leaf
    if isLeaf(node) {
      if parent?.leftChild === node {
        parent?.leftChild = nil
      } else {
        parent?.rightChild = nil
      }

      return
    }

    // case one child
    if hasLeft(node) {
      if parent?.leftChild === node {
        parent?.leftChild = node.leftChild
      } else {
        parent?.rightChild = node.leftChild
      }
      return
    }
    if hasRight(node) {
      if parent?.leftChild === node {
        parent?.leftChild = node.rightChild
      } else {
        parent?.rightChild = node.rightChild
      }
      return
    }

    // case both left & right
    let isRoot = node === root
    var leftMostRightNodeParent = node
    var leftMostRightNode = node.rightChild
    while leftMostRightNode != nil && leftMostRightNode!.leftChild != nil {
      leftMostRightNodeParent = leftMostRightNode!
      leftMostRightNode = leftMostRightNode!.leftChild
    }

    if leftMostRightNodeParent !== node {
      leftMostRightNodeParent.leftChild = leftMostRightNode!.rightChild
      leftMostRightNode!.rightChild = node.rightChild
    }

    leftMostRightNode!.leftChild = node.leftChild
    if parent?.leftChild === node {
      parent?.leftChild = leftMostRightNode
    } else {
      parent?.rightChild = leftMostRightNode
    }
    if isRoot { root = leftMostRightNode }
  }

  public var isValid: Bool {
    isValid(root)
  }

  private func isValid(_ node: BinaryNode<Element>?) -> Bool {
    guard node != nil else {
      return true
    }

    let isLeftValid = node!.leftChild == nil || node!.value > node!.leftChild!.value
    let isRightValid = node!.rightChild == nil || node!.value < node!.rightChild!.value
    return isLeftValid && isRightValid && isValid(node!.leftChild) && isValid(node!.rightChild)
  }
  
  private func isLeaf(_ node: BinaryNode<Element>) -> Bool {
    node.leftChild == nil && node.rightChild == nil
  }

  private func hasLeft(_ node: BinaryNode<Element>) -> Bool {
    node.leftChild != nil && node.rightChild == nil
  }

  private func hasRight(_ node: BinaryNode<Element>) -> Bool {
    node.leftChild == nil && node.rightChild != nil
  }
}

extension BinarySearchTree: CustomStringConvertible {
  public var description: String {
    guard let root = root else {
      return "empty tree"
    }
    return String(describing: root)
  }
}

extension BinarySearchTree: Equatable {
  public static func == (lhs: BinarySearchTree<Element>, rhs: BinarySearchTree<Element>) -> Bool {
    lhs.root == rhs.root
  }
}

extension BinarySearchTree where Element: Hashable {
  public func contains(_ subtree: BinarySearchTree) -> Bool {
    var result = true
    var set = Set<Element>()
    root?.traverseInOrder { set.insert($0) }
    subtree.root?.traverseInOrder { if !set.contains($0) { result = false }  }

    return result
  }
}

extension BinarySearchTree {
  private func leftRotate(_ node: BinaryNode<Element>) -> BinaryNode<Element> {
    let pivot = node.rightChild!
    node.rightChild = pivot.leftChild
    pivot.leftChild = node

    node.height = max(node.leftHeight, node.rightHeight) + 1
    pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1

    return pivot
  }

  private func rightRotate(_ node: BinaryNode<Element>) -> BinaryNode<Element> {
    let pivot = node.leftChild!
    node.leftChild = pivot.rightChild
    pivot.rightChild = node

    node.height = max(node.leftHeight, node.rightHeight) + 1
    pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1

    return pivot
  }

  private func rightLeftRotate(_ node: BinaryNode<Element>) -> BinaryNode<Element> {
    guard let rightChild = node.rightChild else {
      return node
    }
    node.rightChild = rightRotate(rightChild)

    return leftRotate(node)
  }

  private func leftRightRotate(_ node: BinaryNode<Element>) -> BinaryNode<Element> {
    guard let leftChild = node.leftChild else {
      return node
    }
    node.leftChild = leftRotate(leftChild)

    return rightRotate(node)
  }

  private func balanced(_ node: BinaryNode<Element>) -> BinaryNode<Element> {
    switch node.balanceFactor {
    case 2:
      if node.leftChild?.balanceFactor == -1 {
        return leftRightRotate(node)
      } else {
        return rightRotate(node)
      }
    case -2:
      if node.rightChild?.balanceFactor == 1 {
        return rightLeftRotate(node)
      } else {
        return leftRotate(node)
      }
    default:
      return node
    }
  }
}
