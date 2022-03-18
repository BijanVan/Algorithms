//
//  QueueTests.swift
//  AlgorithmsTests
//
//  Created by Bijan Vancouver on 2022-02-21.
//

import XCTest
import Algorithms

class QueueTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testQueueArray() {
    var queue = QueueArray<String>()
    XCTAssert(queue.isEmpty)
    queue.enqueue("a1")
    XCTAssert(!queue.isEmpty)
    XCTAssert(queue.peek == "a1")

    queue.enqueue("b1")
    XCTAssert("\(queue)".trimmingCharacters(in: .whitespacesAndNewlines) == """
              ["a1", "b1"]
              """)
    var elem = queue.dequeue()
    XCTAssert(elem == "a1")
    elem = queue.dequeue()
    XCTAssert(elem == "b1")
    elem = queue.dequeue()
    XCTAssert(elem == nil)
    XCTAssert(queue.isEmpty)
  }

  func testQueueLinkedList() {
    var queue = QueueLinkedList<String>()
    XCTAssert(queue.isEmpty)
    queue.enqueue("a1")
    XCTAssert(!queue.isEmpty)
    XCTAssert(queue.peek == "a1")

    queue.enqueue("b1")
    XCTAssert("\(queue)".trimmingCharacters(in: .whitespacesAndNewlines) == "a1 -> b1 ->")
    var elem = queue.dequeue()
    XCTAssert(elem == "a1")
    elem = queue.dequeue()
    XCTAssert(elem == "b1")
    elem = queue.dequeue()
    XCTAssert(elem == nil)
    XCTAssert(queue.isEmpty)
  }

  func testRingBuffer() {
    var buffer = RingBuffer<Int>(3)
    XCTAssert(!buffer.isFull)
    XCTAssert(buffer.isEmpty)
    XCTAssert(buffer.read() == nil)

    XCTAssert(buffer.write(0))
    XCTAssert(!buffer.isFull)
    XCTAssert(!buffer.isEmpty)

    XCTAssert(buffer.write(1))
    XCTAssert(buffer.write(2))
    XCTAssert(buffer.isFull)
    XCTAssert(!buffer.write(3))

    XCTAssert(buffer.read() == 0)
    XCTAssert(!buffer.isFull)
    XCTAssert(buffer.read() == 1)
    XCTAssert(buffer.write(3))
    XCTAssert(buffer.write(4))
    XCTAssert(buffer.isFull)
    XCTAssert(buffer.read() == 2)
    XCTAssert(buffer.read() == 3)
    XCTAssert(buffer.read() == 4)
  }

  func testQueueRingBuffer() {
    var queue = QueueRingBuffer<String>(2)
    XCTAssert(queue.isEmpty)
    queue.enqueue("a1")
    XCTAssert(!queue.isEmpty)
    XCTAssert(queue.peek == "a1")

    queue.enqueue("b1")
    XCTAssert("\(queue)".trimmingCharacters(in: .whitespacesAndNewlines) == "a1 -> b1 ->")
    XCTAssert(!queue.enqueue("c1"))
    var elem = queue.dequeue()
    XCTAssert(elem == "a1")
    elem = queue.dequeue()
    XCTAssert(elem == "b1")
    elem = queue.dequeue()
    XCTAssert(elem == nil)
    XCTAssert(queue.isEmpty)
  }

  func testQueueStack() {
    var queue = QueueStack<String>()
    XCTAssert(queue.isEmpty)
    queue.enqueue("a1")
    XCTAssert(!queue.isEmpty)
    XCTAssert(queue.peek == "a1")

    queue.enqueue("b1")
    XCTAssert("\(queue)".trimmingCharacters(in: .whitespacesAndNewlines) == """
              ["a1", "b1"]
              """)
    var elem = queue.dequeue()
    XCTAssert(elem == "a1")
    elem = queue.dequeue()
    XCTAssert(elem == "b1")
    elem = queue.dequeue()
    XCTAssert(elem == nil)
    XCTAssert(queue.isEmpty)
  }
}
