import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = (heights: [Int], word: String)
typealias Output = (Int)
typealias Excute = (Input) -> (Output)
typealias Print = (Output) -> ()

func main() {
  let input = readInput
  let output = excute
  let printOut = printOutput
  let run = input |> output |> printOut
  run()
}

func readInput() -> Input {
  let readLineToArray: () -> [Int] = {
    return readLine()!.components(separatedBy:" ").map{Int(String($0))!}
  }
  let readLineToInt: () -> Int = {
    return Int(readLine()!)!
  }
  let readLineToString: ()-> String = {
    return readLine()!
  }
  
  let _readInput: () -> Input = {
    let heights = readLineToArray()
    let string = readLineToString()
    return (heights, string)
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let createHeightDict: ([Int]) -> [String: Int] = { heights in
    var heightDict = [String:Int]()
    for (index, char) in "abcdefghijklmnopqrstuvwxyz".characters.enumerated() {
      heightDict[String(char)] = heights[index]
    }
    return heightDict
  }
  
  let heighestCharOfString:(String, [String:Int]) -> Int = {
    (string, heightDict) in
    let heightsOfString = string.characters.map(){ heightDict[String($0)]! }
    return heightsOfString.max()!
  }
  
  return input.word.characters.count*heighestCharOfString(input.word,
                                                          createHeightDict(input.heights))
}

func printOutput(output: Output) {
  print(output)
}

main()
