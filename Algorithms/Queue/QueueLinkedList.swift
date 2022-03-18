//
//  QueueLinkedList.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-02-24.
//

import Foundation

public struct QueueLinkedList<T>: Queue {
  private var storage = DoublyLinkedList<T>()

  public init() {}

  @discardableResult
  public mutating func enqueue(_ element: T) -> Bool {
    storage.append(element)
    return true
  }

  @discardableResult
  public mutating func dequeue() -> T? {
    guard !isEmpty else {
      return nil
    }

    return storage.remove(storage.first!)
  }

  public var isEmpty: Bool {
    storage.isEmpty
  }

  public var peek: T? {
    storage.first?.value
  }
}

extension QueueLinkedList: CustomStringConvertible {
  public var description: String {
    String(describing: storage)
  }
}
