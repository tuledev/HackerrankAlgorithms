import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = (maxJump:Int, hurdles:[Int])
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
    let maxJump = readLineToArray()[1]
    let hurdles = readLineToArray()
    return (maxJump, hurdles)
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let mustDrink = input.hurdles.max()! - input.maxJump
  return (mustDrink >= 0) ? mustDrink : 0
}

func printOutput(output: Output) {
  print(output)
}

main()
