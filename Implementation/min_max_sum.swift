import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = ([Int])
typealias Output = (min: Int, max: Int)
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
  
  let readNTestCase:()->Int = {
    return readLineToInt()
  }
  
  return readLineToArray()
}

func excute(input: Input) -> Output {
  let total = input.reduce(0, +)
  
  return (total - input.max()!, total - input.min()!)
}

func printOutput(output: Output) {
  print("\(output.min) \(output.max)")
}

main()
