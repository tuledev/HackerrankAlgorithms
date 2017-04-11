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
  
  static func getChar(at: Int, fromString str: String) -> Character {
    return str[str.index(str.startIndex, offsetBy: at)]
  }
  
  static func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
    var chars = Array(myString.characters)     // gets an array of characters
    chars[index] = newChar
    let modifiedString = String(chars)
    return modifiedString
  }
  
  static func swapChar(at index1: Int, and index2: Int, inString str: String) -> String {
    let char1 = getChar(at: index1, fromString: str)
    let char2 = getChar(at: index2, fromString: str)
    let str1 = replace(myString: str, index1, char2)
    let str2 = replace(myString: str1, index2, char1)
    return str2
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

typealias Input = ([String])
typealias Output = ([String])

solve(input: {
  let n = Utils.readLineToInt()
  func readToEnd(remanding: Int, result:[String]) -> [String] {
    if remanding == 0 {
      return result
    }
    else {
      return readToEnd(remanding: remanding - 1, result: result + [Utils.readLineToString()])
    }
  }
  return readToEnd(remanding: n, result:[String]())
},
      output: {
        (result: Output) in
        result.forEach() { print($0) }
}) {
  (input: Input) in
  func greaterThan(_ str: String) -> String {
    func checkingGreater(atIndex index:Int, str: String) -> Int {
      if index < 0 { return -1 }
      
      let char1 =  Utils.getChar(at:index, fromString: str)
      let char2 =  Utils.getChar(at:index+1, fromString: str)
      if (char1 < char2)  {
        return index
      }
      else {
        return checkingGreater(atIndex: index-1, str: str)
      }
    }
    
    func greater(str: String) -> String {
      let greaterIndex = checkingGreater(atIndex: str.characters.count-2, str: str)
      if greaterIndex == -1{
        return "no answer"
      }
      return Utils.swapChar(at: greaterIndex, and: greaterIndex+1, inString: str)
    }
    
    return greater(str: str)
  }
  
  return input.map() { greaterThan($0) }
}
