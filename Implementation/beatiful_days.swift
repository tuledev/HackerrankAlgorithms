import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = (rangeI: Int, rangeJ: Int, divisibleK: Int)
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
    let inputs = readLineToArray()
    return (inputs[0], inputs[1], inputs[2])
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let methodStart = Date()

  let nBeautifulDay = (input.rangeI...input.rangeJ).reduce(0) {
//    let resversedInt: (Int) -> Int = { int in
//      return Int(String(String(int).characters.reversed()))!
//    }
    
    let reversedInt: (Int) -> Int = {
      int in
      var left = int
      var rev = 0
      while left > 0 {
        let r = left % 10
        rev = rev*10 + r
        left = left/10
      }
      return rev
    }
    
    let isBeatifulDay:(Int, Int, Int) -> Bool = {
      (day, resversedDay, divisibleK) in
      
      let differentWithReversed:(Int, Int) -> Int = { abs($0 - $1) }
      let diff = differentWithReversed(day, resversedDay)
      return diff%divisibleK == 0
    }
    
    let reversedDay = reversedInt($1)
    let isBeatiful = isBeatifulDay($1, reversedDay, input.divisibleK)
    return (isBeatiful) ? $0+1 : $0
  }
  
  return nBeautifulDay
}

func printOutput(output: Output) {
  print(output)
}

main()
