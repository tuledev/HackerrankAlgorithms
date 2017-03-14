import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias TestCase = (nPrisioner: Int, nSweets: Int, startPosition: Int)
typealias Input = ([TestCase])
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
    func readTestCase(currentResults: [TestCase], remainding: Int) -> [TestCase] {
      if remainding <= 0 {
        return currentResults
      }
      else {
        let data = readLineToArray()
        let testcase = (nPrisioner: data[0], nSweets: data[1], startPosition: data[2])
        return readTestCase(currentResults: currentResults + [testcase],
                            remainding: remainding-1)
      }
    }
    
    return readTestCase(currentResults: [TestCase](), remainding: nTestCase)
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  let positionOfPoision: (_ testCase: TestCase) -> Int = {
    testCase in
    let circleMod: (_ divisable: Int, _ total: Int) -> Int = {
      divisable, total in
      let mod = divisable%total
      return (mod != 0) ? mod : total
    }
    return circleMod(circleMod(testCase.nSweets, testCase.nPrisioner) + (testCase.startPosition-1),
                     testCase.nPrisioner)
  }
  
  return input.map() {positionOfPoision($0)}
}

func printOutput(output: Output) {
  output.forEach() { print($0) }
}

main()
