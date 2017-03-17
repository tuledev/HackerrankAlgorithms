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

solve(input: {
  let nTestCase = Utils.readLineToInt()
  func readTestCase(remanding: Int, input:[[Int]]) -> [[Int]] {
    if remanding == 0 { return input }
    return readTestCase(remanding: remanding-1, input: input + [Utils.readLineToArray()])
  }
  
  return readTestCase(remanding: nTestCase, input: [[Int]]())
},
      output: {
        (result: [Int]) in
        result.forEach() { print($0) }
}) {
  (input: [[Int]]) in
  let countSquareBetween2Value:(Int, Int) -> Int = {
    let minSquareFrom:(Int) -> Int = {
      let squared = sqrt(Double($0))
      return Int((floor(squared) == squared) ? squared : squared + 1)
    }
    let maxSquareTo:(Int) -> Int = {
      let squared = sqrt(Double($0))
      return Int(squared)
    }
    
    let min = minSquareFrom($0)
    let max = maxSquareTo($1)
    
    return min > max ? 0 : max - min + 1
  }
  
  return input.map() { countSquareBetween2Value($0[0], $0[1]) }
}
