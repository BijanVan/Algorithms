//
//  HeapTests.swift
//  AlgorithmsTests
//
//  Created by Bijan Vancouver on 2022-03-30.
//

import XCTest
import Algorithms

class HeapTests: XCTestCase {
  func testHeap() throws {
    var heap = Heap(sort: <, elements: [1, 12, 3, 4, 1, 6, 8, 7])
    
    while !heap.isEmpty {
      print(heap.remove()!)
    }
  }
}
