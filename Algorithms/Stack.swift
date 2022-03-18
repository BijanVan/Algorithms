//
//  Stack.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-02-14.
//

import Foundation

public struct Stack<Element> {
  private var elements: [Element]

  init(_ elements: [Element]) {
    self.elements = elements
  }

  mutating func push(_ element: Element) {
    elements.append(element)
  }

  @discardableResult
  mutating func pop() -> Element? {
    elements.popLast()
  }

  func peek() -> Element? {
    elements.last
  }

  func isEmpty() -> Bool {
    elements.count == 0
  }
}

extension Stack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    self.elements = elements
  }
}

extension Stack: CustomDebugStringConvertible {
  public var debugDescription: String {
    elements.reversed().map { "\($0)" }.joined(separator: ",")
  }
}
