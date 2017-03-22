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

func solve<Input, Output> (
  input: @escaping ()->Input,
  output: @escaping (Output)->(),
  excute: @escaping (Input)->Output)
{
  let run = input |> excute |> output
  run()
}

typealias Input = ([Int])
typealias Output = ([[Int]])

solve(input: {
  return Utils.readLineToArray() 
},
      output: {
        (result: Output) in
        result.forEach() { print($0) }
}) {
  (input: Input) in
  func powerset(array:[Int]) ->[[Int]] {
    if array.count == 0 {
      return [[]]
    }
    
    let cutFirstArray = array.count > 1 ? Array(array[1...(array.count-1)]) : []
    let subsets = powerset(array:cutFirstArray)
    
    let updatedSubsets = subsets.map() { $0 + [array[0]] }
    
    return subsets + updatedSubsets
  }
  return powerset(array:input)
}
