//
//  RingBuffer.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-02-25.
//

import Foundation

public struct RingBuffer<T> {
  private let count: Int
  private var head = 0
  private var tail = 0
  private var isAllOccupied = false
  private var isSpaceAvailable = true
  private var storage: [T] = []

  public init(_ count: Int) {
    precondition(count > 0, "count must be > 0")
    self.count = count
    storage.reserveCapacity(count)
  }

  public var isEmpty: Bool {
    isSpaceAvailable && head == tail
  }

  public var isFull: Bool {
    !isSpaceAvailable
  }

  public var first: T? {
    guard !isEmpty else {
      return nil
    }
    return storage[head]
  }

  public mutating func write(_ element: T) -> Bool {
    guard !isFull else {
      return false
    }
    if !isAllOccupied {
      storage.append(element)
      isAllOccupied = storage.count == count ? true : false
    } else {
      storage[tail] = element
    }
    tail = (tail + 1) % count
    isSpaceAvailable = head == tail ? false : true
    return true
  }

  public mutating func read() -> T? {
    guard !isEmpty else {
      return nil
    }
    let value = storage[head]
    head = (head + 1) % count
    isSpaceAvailable = true
    return value
  }
}

extension RingBuffer: CustomStringConvertible {
  public var description: String {
    guard !isEmpty else {
      return ""
    }
    var result = ""
    var index = head
    if isFull {
      while index < count {
        result += "\(storage[index]) -> "
        index += 1
      }
      return result
    }

    while index != tail {
      result += "\(storage[index]) -> "
      index = (index + 1) % count
    }
    return result
  }
}
