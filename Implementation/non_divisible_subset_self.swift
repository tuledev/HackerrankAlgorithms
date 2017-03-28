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

typealias Input = (divideNum: Int, array:[Int])
typealias Output = (Int)

solve(input: {
  let divideNum = Utils.readLineToArray()[1]
  return (divideNum, Utils.readLineToArray())
},
      output: {
        (result: Output) in
        print(result)
}) {
  (input: Input) in
  
  var dictRemand = input.array.reduce([Int: Int]()) {
    (result, number) -> [Int: Int] in
    var updatedResult = result
    let remand = number % input.divideNum
    
    if let numOfRemand = updatedResult[remand] {
      updatedResult[remand] = numOfRemand + 1
    }
    else {
      updatedResult[remand] = 1
    }
    return updatedResult
  }
  
  var max = 0
  if input.divideNum > 1 {
    for i in 1...(input.divideNum-1) {
      if dictRemand[i] == nil {
        dictRemand[i] = 0
      }
    }
    
    for i in 1...input.divideNum/2 {
      let lead = i
      let tail = input.divideNum - lead
      if lead != tail {
        let remandLead = dictRemand[lead]!
        let remandTail = dictRemand[tail]!
        max += (remandLead > remandTail) ? remandLead : remandTail
      }
      else {
        max += 1
      }
    }
    if let _ = dictRemand[0] {
      max += 1
    }
  }
  
  return (max == 0) ? 1 : max
}
