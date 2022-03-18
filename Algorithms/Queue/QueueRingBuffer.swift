//
//  QueueRingBuffer.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-02-25.
//

import Foundation

public struct QueueRingBuffer<T>: Queue {
  private var storage: RingBuffer<T>

  public init(_ count: Int) {
    storage = RingBuffer(count)
  }

  @discardableResult
  public mutating func enqueue(_ element: T) -> Bool {
    return storage.write(element)
  }

  @discardableResult
  public mutating func dequeue() -> T? {
    return storage.read()
  }

  public var isEmpty: Bool {
    storage.isEmpty
  }

  public var peek: T? {
    storage.first
  }
}

extension QueueRingBuffer: CustomStringConvertible {
  public var description: String {
    String(describing: storage)
  }
}
