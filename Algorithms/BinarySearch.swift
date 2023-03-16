//
//  BinarySearch.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-03-28.
//

import Foundation

extension RandomAccessCollection where Element: Comparable {
  public func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
    var start = range?.lowerBound ?? startIndex
    var end = range?.upperBound ?? endIndex
    var mid: Index

    while end > start {
      mid = index(start, offsetBy: distance(from: start, to: end) / 2)
      if value > self[mid] {
        start = mid
      } else if value < self[mid] {
        end = mid
      } else {
        return mid
      }
    }
    
    return nil
  }
}
