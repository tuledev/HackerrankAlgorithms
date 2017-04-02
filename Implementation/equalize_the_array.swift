import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

struct Utils {
  
  static func readLineToArray()->[Int] {
    return readLine()!.components(separatedBy:" ").map{Int(String($0))!}
  }
  
  static func readLineToInt()->Int {
    return Int(readLine()!)!
  }
  
  static func readLineToString() -> String {
    return readLine()!
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
typealias Output = (Int)

solve(input: {
  Utils.readLineToInt()
  return (Utils.readLineToArray())
},
      output: {
        (result: Output) in
        print(result)
}) {
  (input: Input) in
  let dictNumOfNumbers = input.reduce([Int:Int]()) {
    (result, number) -> [Int:Int] in
    var updatedResult = result
    if updatedResult[number] == nil {
      updatedResult[number] = 1
    }
    else {
      updatedResult[number] = 1 + updatedResult[number]!
    }
    return updatedResult
  }
  return input.count - dictNumOfNumbers.keys.map(){ dictNumOfNumbers[$0]! }.max()!
}
