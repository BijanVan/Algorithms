//
//  TrieTests.swift
//  AlgorithmsTests
//
//  Created by Bijan Vancouver on 2022-03-24.
//

import XCTest
import Algorithms

class TrieTests: XCTestCase {
  func testContains() {
    let trie = Trie<String>()
    trie.insert("cute")
    XCTAssert(trie.contains("cute"))
  }

  func testRemove() {
    let trie = Trie<String>()
    trie.insert("cut")
    trie.insert("cute")
    XCTAssert(trie.contains("cut"))
    XCTAssert(trie.contains("cute"))
    XCTAssert(trie.remove("cut"))
    XCTAssert(!trie.contains("cut"))
    XCTAssert(trie.contains("cute"))
  }

  func testPrefix() {
    let trie = Trie<String>()
    trie.insert("car")
    trie.insert("card")
    trie.insert("care")
    trie.insert("cared")
    trie.insert("cars")
    trie.insert("carbs")
    trie.insert("carapace")
    trie.insert("cargo")

    XCTAssertEqual(trie.start(with: "car").sorted(),
                   ["carr", "carrapace", "carrbs", "carrd", "carre", "carred", "carrgo", "carrs"])

    XCTAssertEqual(trie.start(with: "care").sorted(), ["caree", "careed"])
  }
}
