//
//  QueueStack.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-02-27.
//

import Foundation

public struct QueueStack<T>: Queue {
  private var storageEnqueue: [T] = []
  private var storageDequeue: [T] = []

  public init() {}

  @discardableResult
  public mutating func enqueue(_ element: T) -> Bool {
    storageEnqueue.append(element)
    return true
  }

  public mutating func dequeue() -> T? {
    if storageDequeue.isEmpty {
      while !storageEnqueue.isEmpty {
        storageDequeue.append(storageEnqueue.popLast()!)
      }
    }
    return storageDequeue.popLast()
  }

  public var isEmpty: Bool {
    storageEnqueue.isEmpty && storageDequeue.isEmpty
  }

  public var peek: T? {
    if !storageDequeue.isEmpty {
      return storageDequeue.last
    }
    return storageEnqueue.first
  }
}

extension QueueStack: CustomStringConvertible {
  public var description: String {
    String(describing: storageDequeue.reversed() + storageEnqueue)
  }
}
