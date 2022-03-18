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

    while let iterNode = node {
      if value < iterNode.value {
        node = iterNode.leftChild
        iterNode.leftChild = node ?? BinaryNode(value)
      } else {
        node = iterNode.rightChild
        iterNode.rightChild = node ?? BinaryNode(value)
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
