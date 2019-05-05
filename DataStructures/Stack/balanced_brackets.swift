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

protocol StackItem {
  var value: String { get }
}

extension String: StackItem {
  var value: String {
    get { return self }
  }
}

class Stack: StackProtocol {
  var stack = [StackItem]()
}

let PAIR = ["}":"{", ")":"(", "]":"["]

typealias Input = ([String], [String])
typealias Output = [Int]

func main() {
  let nLine = Utils.readLineToInt()
  var inputs = [String]()
  for _ in 0..<nLine {
    inputs.append(readLine()!)
  }
  inputs.map({ isBalanced($0) }).forEach({ print($0) })
}

func isBalanced(_ s: String) -> String {
  let bracketArray = Array(s).map({ String($0) })
  var stack = Stack()
  for bracket in bracketArray {
    print(stack.top()?.value)
    print(PAIR[bracket])
    if stack.top() != nil && stack.top()?.value == PAIR[bracket] {
      stack.pop()
    } else {
      stack.push(bracket)
    }
  }
  return stack.top() == nil ? "YES" : "NO"
}

main()
