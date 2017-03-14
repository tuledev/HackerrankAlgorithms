import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = (houses:[Int], trees:[Int], apples:[Int], oranges:[Int])
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
    let houses = readLineToArray()
    let trees = readLineToArray()
    let ignoreline = readLineToArray()
    let apples = readLineToArray()
    let oranges = readLineToArray()
    return (houses, trees, apples, oranges)
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let applesPosition = input.apples.map() { $0 + input.trees[0] }
  let orangesPosition = input.oranges.map() { $0 + input.trees[1] }
  
  let positionInHouse: (Int,[Int]) -> Bool = {
    (position, houses) in
    return (houses[0] <= position && position <= houses[1])
  }
  
  let applesInHouse = applesPosition.filter() { positionInHouse($0, input.houses) }
  let orangeInHouse = orangesPosition.filter() { positionInHouse($0, input.houses) }
  return [applesInHouse.count, orangeInHouse.count]
}

func printOutput(output: Output) {
  output.forEach(){ print($0) }
}

main()
