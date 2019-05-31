
import Foundation

func removeDuplicates<Element: Equatable>(array: [Element]) -> [Element]{
  var result = [Element]()
  for value in array {
    if !result.contains(value) {
      result.append(value)
    }
  }
  return result
}

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

// - - - - - - - - - - - - - - -

class LinkedNode {
  var data: Int
  var next: LinkedNode?
  init(data: Int) {
    self.data = data
  }
}

class LinkedList {
  var head: LinkedNode?
  var tail: LinkedNode?
  
  func insert(_ data: Int) {
    insertNode(LinkedNode(data: data));
  }
  
  private func insertNode(_ node: LinkedNode) {
    if let tail = tail {
      tail.next = node
    } else {
      head = node
    }
    tail = node
  }
}

// - - - - - - - - - - - - - - -

typealias Input = ([Int])
typealias Output = LinkedNode?

func input() -> (Input) {
  let totalInput = Int(readLine()!)!
  var inputs = [Int]()
  for _ in (0..<totalInput) {
    inputs.append(Int(readLine()!)!);
  }
  return (inputs)
}

func output(_ result: Output) {
  if let node = result {
    print(node.data)
    output(node.next)
  }
}

func excute(_ data: (Input)) -> Output {
  let linkedList = LinkedList()
  data.forEach({ linkedList.insert($0) })
  return linkedList.head
}

let data = input()
let result = excute(data)
output(result)



