
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

typealias Input = ([String], [String])
typealias Output = [Int]

func input() -> (Input) {
  let totalInput = Utils.readLineToInt();
  var inputs = [String]()
  for _ in (0..<totalInput) {
    inputs.append(readLine()!);
  }
  let totalQueries = Utils.readLineToInt()
  var queries = [String]()
  for _ in (0..<totalQueries) {
    queries.append(readLine()!);
  }
  return (inputs, queries)
}

func output(_ result: Output) {
  print("result", result)
}

func excute(_ data: (Input)) -> Output {
  let inputs = data.0
  let queries = data.1
  
  let query: (_ key: String,_ array: [String]) -> Int = { (key, array) in
    return array.map{ $0 == key ? 1 : 0 }.reduce(0, +)
  }
  
  return queries.map{ query($0, inputs) }
}

let data = input()
let result = excute(data)
output(result)


