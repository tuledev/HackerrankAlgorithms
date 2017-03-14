import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = ([Int])
typealias Output = ([Int])
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
    return readLineToArray()
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let pn = input
  let fn = pn.reduce([Int:Int]()) {
    var dict = $0
    dict[$1] = pn.index(of:$1)! + 1
    return dict
  }
  return (1...input.count).map() { fn[fn[$0]!]! }
}

func printOutput(output: Output) {
  output.forEach() { print($0) }
}

main()
