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

typealias Input = (initialString: String, nLetter: Int)
typealias Output = (Int)

solve(input: {
  return (Utils.readLineToString(), Utils.readLineToInt())
},
      output: {
        (result: Output) in
        print(result)
}) {
  (input: Input) in
  let letter = "a"
  func numOf(character: String, inString str: String) -> Int {
    return str.characters.filter{String($0) == letter}.count
  }
  let numOfAInInittialString = numOf(character: letter,
                                     inString:input.initialString)
  
  let repeatedCount = input.nLetter/input.initialString.characters.count
  let remandLetter = input.nLetter%input.initialString.characters.count
  
  let idx = input.initialString.index(input.initialString.startIndex,
                                      offsetBy:remandLetter)
  let numOfRemandAInString = numOf(character: letter,
                                   inString: input.initialString.substring(to:idx))
  
  return numOfAInInittialString * repeatedCount + numOfRemandAInString
}
