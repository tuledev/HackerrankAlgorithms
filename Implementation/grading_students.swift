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
  
  let _readInput: () -> [Int] = {
    let n = readLineToInt()
    var input = [Int]()
    
    for _ in 0..<n {
      input.append(readLineToInt())
    }
    return input
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let roundScore: (Int) -> Int = {
    score in
    let rounding: (Int) -> Int = {
      canRoundScore in
      return (canRoundScore%5<=2) ? canRoundScore : (canRoundScore+5)/5*5
    }
    
    return score < 38 ? score : rounding(score)
  }
  
  return input.map() {roundScore($0)}
}

func printOutput(output: Output) {
  output.forEach(){ print($0) }
}

main()
