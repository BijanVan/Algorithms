//
//  DoublyLinkedList.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-02-22.
//

import Foundation

public class DoublyLinkedList<T> {
  private var head: DoublyNode<T>?
  private var tail: DoublyNode<T>?

  public init() {}

  public var isEmpty: Bool {
    head == nil
  }

  public var first: DoublyNode<T>? {
    head
  }

  public func append(_ value: T) {
    let node = DoublyNode(value)
    guard !isEmpty else {
      head = node
      tail = node
      return
    }
    node.previous = tail
    tail?.next = node
    tail = node
  }

  public func remove(_ node: DoublyNode<T>) -> T {
    guard !(head === tail) else {
      head = nil
      tail = nil
      return node.value
    }

    head = node === head ? head?.next : head
    tail = node === tail ? tail?.previous : tail

    let prev = node.previous
    let next = node.next
    prev?.next = node.next
    next?.previous = node.previous

    node.previous = nil
    node.next = nil

    return node.value
  }
}

extension DoublyLinkedList: CustomStringConvertible {
  public var description: String {
    var nodeIter = head
    var str = ""
    while let node = nodeIter {
      str += "\(node) -> "

      nodeIter = node.next
    }

    return str
  }
}

struct DoublyLinkedListIterator<T>: IteratorProtocol {
  private var node: DoublyNode<T>?

  init(node: DoublyNode<T>?) {
    self.node = node
  }

  mutating func next() -> DoublyNode<T>? {
    let current = node
    node = node?.next
    return current
  }
}

extension DoublyLinkedList: Sequence {
  public func makeIterator() -> some IteratorProtocol {
    DoublyLinkedListIterator(node: head)
  }
}

// MARK: DoublyNode
public class DoublyNode<Value> {
  public var value: Value
  public var next: DoublyNode?
  public var previous: DoublyNode?

  public init(_ value: Value) {
    self.value = value
  }
}

extension DoublyNode: CustomStringConvertible {
  public var description: String {
    String(describing: value)
  }
}
