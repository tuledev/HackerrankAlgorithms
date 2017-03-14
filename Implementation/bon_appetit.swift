import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = (kItem: Int, cost: [Int], charged: Int)
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
    let kItem = readLineToArray()[1]
    let cost = readLineToArray()
    let charged = readLineToInt()
    return (kItem, cost, charged)
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let total = input.cost.reduce(0, +)
  let shouldCharge = (total - input.cost[input.kItem])/2
  return input.charged - shouldCharge
}

func printOutput(output: Output) {
  print((output != 0) ? output : "Bon Appetit")
}

main()
