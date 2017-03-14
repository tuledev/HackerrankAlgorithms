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
    let nGrowns = readLineToInt()
    func readGrowsInput(nGrowns:Int, currentGrows:[Int]) -> [Int] {
      return (nGrowns > 0) ?  readGrowsInput(nGrowns: nGrowns-1, currentGrows: currentGrows + [readLineToInt()]) : currentGrows
    }
    return readGrowsInput(nGrowns: nGrowns,currentGrows: [Int]())
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  
  func grow(currentHeight: Int,
            currentNGrows:Int,
            remaindingGrow: Int) -> Int {
    let springGrow: (Int) -> Int = { $0*2 }
    let summerGrow: (Int) -> Int = { $0+1 }
    if remaindingGrow == 0 {
      return currentHeight
    }
    else {
      return grow(currentHeight: (currentNGrows%2==0) ? springGrow(currentHeight) : summerGrow(currentHeight),
                  currentNGrows: currentNGrows+1,
                  remaindingGrow: remaindingGrow-1)
    }
  }
  return input.map() {
    grow( currentHeight: 1,currentNGrows: 0,remaindingGrow: $0)
  }
}

func printOutput(output: Output) {
  output.forEach() { print($0) }
}

main()
