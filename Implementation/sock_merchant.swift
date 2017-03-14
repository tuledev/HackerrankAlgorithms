import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = ([Int])
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
  let readLineToArray: ()->[Int] = {
    return readLine()!.components(separatedBy:" ").map{Int(String($0))!}
  }
  let readLineToInt: ()->Int = {
    return Int(readLine()!)!
  }
  
  let _readInput: () -> Input = {
    readLineToInt()
    let ids = readLineToArray()
    return ids
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  func reducePairValue(values: [Int]) -> [Int] {
    var reducedValues = values
    for (index1, value1) in values.enumerated() {
      for index2 in (index1+1)..<values.count {
        if value1 == values[index2] {
          reducedValues.remove(at: index2)
          reducedValues.remove(at: index1)
          return reducePairValue(values: reducedValues)
        }
      }
    }
    return reducedValues
  }
  
  let remaindingValues = reducePairValue(values: input)
  
  return (input.count - remaindingValues.count)/2
}

func printOutput(output: Output) {
  print(output)
}

main()
