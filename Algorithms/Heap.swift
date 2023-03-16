//
//  Heap.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-03-28.
//

import Foundation

public struct Heap<Element: Comparable> {
  var elements: [Element] = []
  let sort: (Element, Element) -> Bool
  
  public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
    self.sort = sort
    self.elements = elements

    if !elements.isEmpty {
      for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
        siftDown(at: i)
      }
    }
  }
  
  public var isEmpty: Bool {
    elements.isEmpty
  }

  public var count: Int {
    elements.count
  }

  public func peek() -> Element? {
    elements.first
  }
  
  public mutating func remove() -> Element? {
    guard !isEmpty else {
      return nil
    }
    elements.swapAt(0, count - 1)
    defer { siftDown(at: 0) }
    return elements.popLast()
  }

  private mutating func siftDown(at index: Int) {
    var candidate = 0
    let left = leftChildIndex(at: index)
    let right = rightChildIndex(at: index)

    if left < count && sort(elements[index], elements[left]) {
      candidate = left
    } else if right < count && sort(elements[index], elements[right]) {
      candidate = right
    } else {
      return
    }
    elements.swapAt(candidate, index)
    siftDown(at: candidate)
  }

  private func leftChildIndex(at index: Int) -> Int { 2 * index + 1 }

  private func rightChildIndex(at index: Int) -> Int { 2 * index + 2 }

  private func parentIndex(at index: Int) -> Int { (index - 1) / 2 }
}
