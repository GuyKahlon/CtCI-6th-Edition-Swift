// Cracking the Coding Interview 6th Edition Solutions

import Foundation

enum StackException: ErrorProtocol {
  case EmptyStack
}

private class StackNode<Element> {
  var data: Element
  var next: StackNode<Element>?
  
  init(data: Element) {
    self.data = data
  }
}

protocol StackProtocol {
  
  associatedtype ItemType
  
  mutating func pop() throws -> ItemType
  mutating func push(data: ItemType)
  func peek() throws -> ItemType
  func isEmpty() -> Bool
}

public struct MyStack<Element>: StackProtocol {
  
  typealias ItemType = Element
  
  private var top: StackNode<Element>?
  
  mutating func pop() throws -> Element {
    
    guard let currentTop = top else {
      throw StackException.EmptyStack
    }
    
    let retValue = currentTop.data
    top = currentTop.next
    
    return retValue
  }
  
  mutating func push(data: Element) {
    
    let node = StackNode(data: data)
    node.next = top
    top = node
  }
  
  func peek() throws -> Element {
    
    guard let currentTop = top else {
      throw StackException.EmptyStack
    }
    
    return currentTop.data
  }
  
  func isEmpty() -> Bool {
    return top == nil
  }
}

// MARK: Question 3.2
protocol StackWithMinimumProtocol: StackProtocol {
  
  var minimum: () throws -> ItemType { get }
}

struct StackWithMinimum<Element: Comparable>: StackWithMinimumProtocol {
  
  private var stack = MyStack<Element>()
  private var minimumStack = MyStack<Element>()
  
  typealias ItemType = Element
  
  mutating func pop() throws -> Element {
    
    let retValue = try stack.pop()
    let currentMinValue = try minimumStack.peek()
    
    if retValue == currentMinValue {
      let _ = try minimumStack.pop()
    }
    
    return retValue
  }
  
  mutating func push(data: Element) {
    
    stack.push(data: data)
    if minimumStack.isEmpty() {
      minimumStack.push(data: data)
    } else {
      let currentMinValue = try! minimumStack.peek()
      if currentMinValue >= data {
        minimumStack.push(data: data)
      }
    }
  }
  
  func peek() throws -> Element {
    return try stack.peek()
  }
  
  func isEmpty() -> Bool {
    return stack.isEmpty()
  }
  
  var minimum: () throws ->Element {
    return minimumStack.peek
  }
}
