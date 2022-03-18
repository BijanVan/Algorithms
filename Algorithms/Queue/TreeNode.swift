//
//  TreeNode.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-03-01.
//

import Foundation

public class TreeNode<T> {
  public var value: T
  public var children: [TreeNode] = []

  public init(_ value: T) {
    self.value = value
  }

  public func add(_ child: TreeNode) {
    children.append(child)
  }
}

extension TreeNode {
  public func forEachDepthFirst(visit: (TreeNode) -> Void) {
    visit(self)
    for node in children {
      node.forEachDepthFirst(visit: visit)
    }
  }

  public func forEachLevelOrder(visit: (TreeNode) -> Void) {
    var queue = QueueStack<TreeNode>()
    queue.enqueue(self)

    while let node = queue.dequeue() {
      visit(node)
      for child in node.children {
        queue.enqueue(child)
      }
    }
  }
}

extension TreeNode where T: Equatable {
  public func search(_ value: T) -> TreeNode? {
    if self.value == value {
      return self
    }

    var queue = QueueStack<TreeNode>()
    queue.enqueue(self)

    while let node = queue.dequeue() {
      if node.value == value {
        return node
      }
      for child in node.children {
        queue.enqueue(child)
      }
    }

    return nil
  }
}
