import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = (Int)
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
    return readLineToInt()
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  func grow(remainingDay: Int, nCurrentPersons: Int, nLikedPerson: Int) -> Int {
    if remainingDay <= 0 {
      return nLikedPerson
    }
    else {
      let growPerson = nCurrentPersons/2*3
      return grow(remainingDay: remainingDay-1,
                  nCurrentPersons: growPerson,
                  nLikedPerson: growPerson/2+nLikedPerson)
    }
  }
  
  return grow(remainingDay: input-1, nCurrentPersons: 5, nLikedPerson: 5/2)
}

func printOutput(output: Output) {
  print(output)
}

main()
