//
//  LinkedList.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-02-15.
//

import Foundation

public struct LinkedList<Value> {
  var head: Node<Value>?
  var tail: Node<Value>?

  public init() {}

  public var isEmpty: Bool {
    head == nil && tail == nil
  }

  public mutating func push(_ value: Value) {
    copyNodes()
    head = Node(value, next: head)
    tail = tail ?? head
  }

  public func node(at index: Int) -> Node<Value>? {
    var counter = 0
    var node = head
    while counter < index && node !== tail {
      counter += 1
      node = node!.next
    }

    return counter == index ? node : nil
  }

  @discardableResult
  public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
    copyNodes()
    let instertedNode = Node(value, next: node.next)
    if node === tail {
      tail = instertedNode
    }
    node.next = instertedNode
    return instertedNode
  }

  public mutating func append(_ value: Value) {
    copyNodes()
    guard !isEmpty else {
      push(value)
      return
    }

    tail!.next = Node(value)
    tail = tail!.next
  }

  @discardableResult
  public mutating func pop() -> Value? {
    copyNodes()
    let value = head?.value
    head = head?.next
    if head == nil {
      tail = nil
    }
    return value
  }

  @discardableResult
  public mutating func removeLast() -> Value? {
    copyNodes()
    guard head !== tail else {
      return pop()
    }
    
    let value = tail?.value

    var nodeBefore = head
    while nodeBefore?.next !== tail {
      nodeBefore = nodeBefore?.next
    }
    tail = nodeBefore
    tail?.next = nil

    if tail == nil {
      head = nil
    }
    return value
  }

  @discardableResult
  public mutating func remove(after node: Node<Value>) -> Value? {
    var node = node
    let isNodeHead = node === head
    copyNodes()
    if isNodeHead {
      node = head!
    }
    let value = node.next?.value
    if node.next === tail {
      tail = node
    }
    node.next = node.next?.next

    return value
  }

  private mutating func copyNodes() {
    guard !isEmpty && !isKnownUniquelyReferenced(&head) else {
      return
    }

    let newHead = Node(head!.value)
    var newNodeIter = newHead
    var oldNodeIter = head!
    while let node = oldNodeIter.next {
      newNodeIter.next = Node(node.value)
      newNodeIter = newNodeIter.next!
      oldNodeIter = oldNodeIter.next!
    }

    head = newHead
    tail = newNodeIter
  }

  private func newCopyNodes() -> (Node<Value>?, Node<Value>?) {
    guard !isEmpty else {
      return (nil, nil)
    }
    let newHead = Node(head!.value)
    var newNodeIter = newHead
    var nodeIter = head?.next

    while let node = nodeIter {
      newNodeIter.next = Node(node.value)
      newNodeIter = newNodeIter.next!
      nodeIter = nodeIter?.next
    }
    return (newHead, newNodeIter)
  }
}

// MARK: Utility functions
extension LinkedList {
  public mutating func append(_ list: LinkedList) {
    let (head1, tail1) = list.newCopyNodes()
    head = head ?? head1
    tail?.next = head1
    tail = tail1 ?? tail
  }

  public mutating func removeAll(_ value: Value) where Value: Equatable {
    guard head !== tail else {
      return
    }

    var node1: Node<Value>?
    var node2 = head
    while node2 !== nil {
      if node2!.value == value {
        node1?.next = node2!.next
        head = head === node2 ? head?.next : head
        tail = tail === node2 ? node1 : tail
      } else {
        node1 = node2
      }
      node2 = node2!.next
    }
  }
}

// MARK: String converter
extension LinkedList: CustomStringConvertible {
  public var description: String {
    guard head != nil else {
      return "Empty list"
    }
    return String(describing: head!)
  }
}

// MARK: Collection protocol
extension LinkedList: Collection {
  public var startIndex: Index {
    Index(node: head)
  }

  public var endIndex: Index {
    Index(node: tail?.next)
  }

  public func index(after index: Index) -> Index {
    Index(node: index.node?.next)
  }
  
  public subscript(position: Index) -> Value {
    position.node!.value
  }

  public struct Index: Comparable {
    public let node: Node<Value>?

    public static func == (lhs: Index, rhs: Index) -> Bool {
      lhs.node === rhs.node
    }

    public static func < (lhs: Index, rhs: Index) -> Bool {
      guard lhs != rhs else {
        return false
      }
      let nodes = sequence(first: lhs.node) { $0?.next }
      return nodes.contains { $0 === rhs.node }
    }
  }
}

// MARK: Node
public class Node<Value> {
  public var value: Value
  public var next: Node?

  public init(_ value: Value, next: Node? = nil) {
    self.value = value
    self.next = next
  }
}

extension Node: CustomStringConvertible {
  public var description: String {
    guard let next =  self.next else {
      return "\(value)"
    }
    return "\(value) -> " + String(describing: next) + " "
  }
}
