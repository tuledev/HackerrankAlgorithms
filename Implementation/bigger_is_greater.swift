
import Foundation

typealias InputType = [String]
typealias OutputType = [String]


///////////////////////////////////////

func swapChar(chars: [Character], index: Int, swapIndex: Int) -> [Character] {
  var resultsChars = chars
  let tempChar = resultsChtouch ars[index]
  resultsChars[index] = resultsChars[swapIndex]
  resultsChars[swapIndex] = tempChar
  return resultsChars
}

func sortChars(chars: [Character], fromIndex: Int) -> [Character] {
  let resultsChars = Array(chars.prefix(fromIndex))
    + Array(chars.suffix(from: fromIndex).reversed())
  return resultsChars
}

func biggerIsGreater(_ testcase: String) -> String {
  var chars = Array(testcase)
  for index in (0..<(chars.count-1)).reversed() {
    for tailIndex in ((index+1)..<(chars.count)).reversed() {
      if chars[index] < chars[tailIndex] {
        chars = swapChar(chars: chars, index: index, swapIndex: tailIndex)
        return String(sortChars(chars: chars, fromIndex: index+1))
      }
    }
  }
  return "no answer"
}

func solve(_ testcases: InputType) -> OutputType {
  return testcases.map{ biggerIsGreater($0) }
}
///////////////////////////////////////

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return {return right(left($0))}
}

struct Utils {
  
  static func readLineToArray()->[Int] {
    return readLine()!.components(separatedBy:" ").map{Int(String($0))!}
  }
  
  static  func readLineToInt()->Int {
    return Int(readLine()!)!
  }
  
}

let input: (Int) -> (InputType) = { _ in
  let numberInput = Utils.readLineToInt()
  var testCases = [String]()
  for _ in 0..<numberInput {
    testCases.append(readLine()!)
  }
  return testCases
}

let output: (OutputType) -> () = {
  print("result", $0)
}

let excute: (InputType) -> (OutputType) = {
  return solve($0)
}

//////////////////////////////////////////////////
let startTime = CFAbsoluteTimeGetCurrent()
let run = input |> excute |> output
run(1)
let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
print("time: ", timeElapsed)
