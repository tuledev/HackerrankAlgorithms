import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

struct Utils {
  
  static func readLineToArray()->[Int] {
    return readLine()!.components(separatedBy:" ").map{Int(String($0))!}
  }
  
  static  func readLineToInt()->Int {
    return Int(readLine()!)!
  }
}

protocol StackProtocol {
  var stack: [StackItem] { get set }
  mutating func pop() -> StackItem?
  mutating func push(_ item: StackItem)
  func top() -> StackItem?
}

extension StackProtocol {
  mutating func pop() -> StackItem? {
    return stack.popLast()
  }
  mutating func push(_ item: StackItem) {
    stack.append(item)
  }
  func top() -> StackItem? {
    return stack.last
  }
}

protocol MaxStackProtocol {
  var stack: [StackItem] { get set }
  mutating func pop() -> StackItem?
  mutating func push(_ item: StackItem)
  func top() -> StackItem?
}

extension MaxStackProtocol {
  mutating func pop() -> StackItem? {
    return stack.popLast()
  }
  mutating func push(_ item: StackItem) {
    if let top = top() {
      stack.append(item.value > top.value ? item : top)
    } else {
      stack.append(item)
    }
  }
  func top() -> StackItem? {
    return stack.last
  }
}

struct Stack2<T> {
  var stack = [T]()
  mutating func pop() -> T? {
    return stack.popLast()
  }
  mutating func push(_ item: T) {
    stack.append(item)
  }
  func top() -> T? {
    return stack.last
  }
}

protocol StackItem {
  var value: Int { get }
}

extension Int: StackItem {
  var value: Int {
    get { return self }
  }
}

//struct Stack: StackProtocol {
//  var stack = [Int]()
//}

//struct Stack3 {
//  var stack = [StackItem]()
//  mutating func pop() -> StackItem? {
//    return stack.popLast()
//  }
//  mutating func push(_ item: StackItem) {
//    stack.append(item)
//  }
//  func top() -> StackItem? {
//    return stack.last
//  }
//}

class Stack4: StackProtocol {
  var stack = [StackItem]()
}

class MaxStack: MaxStackProtocol {
  var stack = [StackItem]()
}

typealias Input = ([String], [String])
typealias Output = [Int]

func main() {
  let nLine = Utils.readLineToInt()
  var stack = Stack4()
  var maxStack = MaxStack()
  for _ in 0..<nLine {
    let command = Utils.readLineToArray()
    let type = command[0]
    var data = 0
    if (command.count == 2) {
      data = command[1]
    }
    excuteCommand(stack: &stack, maxStack: &maxStack, type: type, data: data)
  }
}

func excuteCommand(stack: inout Stack4, maxStack: inout MaxStack, type: Int, data: Int) {
  switch type {
  case 1:
    stack.push(data)
    maxStack.push(data)
  case 2:
    let _  = stack.pop()
    let _  = maxStack.pop()
  default:
    print(maxStack.top() ?? 0)
  }
}


main()
