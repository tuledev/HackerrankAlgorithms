import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = (nJump: Int, clouds:[Int])
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
    let nJump = readLineToArray()[1]
    let clouds = readLineToArray()
    return (nJump, clouds)
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let totalJumpStep = input.clouds.count/input.nJump
  let nThunderCloudJumpOn = input.clouds.enumerated().reduce(0) {
    (result, currentElem) in
    return (currentElem.0%input.nJump == 0 && currentElem.1 == 1) ? result+1 : result
  }
  return 100 - (totalJumpStep*1 + nThunderCloudJumpOn*2)
}

func printOutput(output: Output) {
  print(output)
}

main()
