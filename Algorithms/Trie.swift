//
//  Trie.swift
//  Algorithms
//
//  Created by Bijan Vancouver on 2022-03-23.
//

import Foundation

public class TrieNode<Key: Hashable> {
  public var key: Key?
  public weak var parent: TrieNode?
  public var children: [Key: TrieNode] = [:]
  public var isTerminating = false

  public init(key: Key?, parent: TrieNode?) {
    self.key = key
    self.parent = parent
  }
}

public class Trie<Base: Collection> where Base.Element: Hashable {
  public typealias Element = TrieNode<Base.Element>
  public init() {}
  private let root = Element(key: nil, parent: nil)

  public func insert(_ base: Base) {
    var node = root
    for elem in base {
      if !node.children.keys.contains(elem) {
        node.children[elem] = TrieNode(key: elem, parent: node)
      }
      node = node.children[elem]!
    }
    node.isTerminating = true
  }

  public func contains(_ base: Base) -> Bool {
    var node = root
    for elem in base {
      if !node.children.keys.contains(elem) {
        return false
      }
      node = node.children[elem]!
    }

    return node.isTerminating
  }

  public func remove(_ base: Base) -> Bool {
    var node = root
    for elem in base {
      if !node.children.keys.contains(elem) {
        return false
      }
      node = node.children[elem]!
    }
    node.isTerminating = false

    while let parent = node.parent, !node.isTerminating && parent.children.isEmpty {
      parent.children[node.key!] = nil
      node = parent
    }
    
    return true
  }
}

extension Trie where Base: RangeReplaceableCollection {
  public func start(with prefix: Base) -> [Base] {
    var node = root
    for elem in prefix {
      if !node.children.keys.contains(elem) {
        return []
      }
      node = node.children[elem]!
    }
    return start(with: prefix, after: node)
  }

  private func start(with prefix: Base, after node: Element) -> [Base] {
    var base: Base = prefix
    var bases: [Base] = []
    base.append(node.key!)
    if node.isTerminating {
      bases.append(base)
    }
    for child in node.children {
      bases.append(contentsOf: start(with: base, after: child.value))
    }

    return bases
  }
}
