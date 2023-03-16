//
//  BinarySearchTests.swift
//  AlgorithmsTests
//
//  Created by Bijan Vancouver on 2022-03-28.
//

import XCTest

class BinarySearchTests: XCTestCase {
  func testBinarySearch() {
    let array = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]
    XCTAssertEqual(array.binarySearch(for: 31), array.firstIndex(of: 31))
  }
}
