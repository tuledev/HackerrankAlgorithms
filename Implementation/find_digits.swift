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
    let nTestCase = readLineToInt()
    func readTestCase(remainding: Int, result:[Int]) -> [Int] {
      if remainding == 0 {
        return result
      }
      else {
        return readTestCase(remainding: remainding - 1, result: result + [readLineToInt()])
      }
    }
    return readTestCase(remainding: nTestCase, result: [Int]())
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let countEvenlyDivide: (Int) -> Int = {
    func evenlyDivideDigit(number: Int, remaindDigits: Int, count: Int) -> Int {
      let isEvenly: (_ number:Int, _ divide:Int) -> Bool = {
        return $1 == 0 ? false : $0 % $1 == 0
      }
      
      if remaindDigits == 0 {
        return count
      }
      else {
        let inscreasedCount = isEvenly(number, remaindDigits%10) ? count + 1 : count
        return evenlyDivideDigit(number:number,
                                 remaindDigits: remaindDigits/10,
                                 count: inscreasedCount)
      }
    }
    return evenlyDivideDigit(number: $0, remaindDigits: $0, count: 0)
  }
  return input.map() { countEvenlyDivide($0) }
}

func printOutput(output: Output) {
  output.forEach() {print($0)}
}

main()
