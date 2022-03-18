//
//  QueueArray.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-02-24.
//

import Foundation

public struct QueueArray<T>: Queue {
  private var storage: [T] = []

  public init() {}

  @discardableResult
  public mutating func enqueue(_ element: T) -> Bool {
    storage.append(element)
    return true
  }

  @discardableResult
  public mutating func dequeue() -> T? {
    return storage.isEmpty ? nil : storage.removeFirst()
  }

  public var isEmpty: Bool {
    storage.isEmpty
  }

  public var peek: T? {
    storage.first
  }
}

extension QueueArray: CustomStringConvertible {
  public var description: String {
    String(describing: storage)
  }
}
