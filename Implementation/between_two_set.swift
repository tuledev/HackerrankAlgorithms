import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
  print(any)
}

typealias Input = (arrayDown:[Int],arrayUp:[Int])
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
  
  let _readInput: () -> ([Int],[Int]) = {
    let _ = readLineToArray()
    let down = readLineToArray()
    let up = readLineToArray()
    return (down,up)
  }
  
  return _readInput()
}

func excute(input: Input) -> Output {
  
  if input.arrayDown.max()! > input.arrayUp.min()! {
    return 0
  }
  
  func gcd(a:Int, b:Int) -> Int {
    if a == b {
      return a
    }
    else {
      if a > b {
        return gcd(a:a-b,b:b)
      }
      else {
        return gcd(a:a,b:b-a)
      }
    }
  }
  
  func lcm(a:Int, b:Int) -> Int {
    return a*b / gcd(a: a,b: b)
  }
  
  let calArrayWithReduce: ([Int], (Int, Int) -> Int) -> Int = {
    (arr, progress) in
    return arr.reduce(arr.min()!) { progress($0, $1)}
  }
  
  let lcmDownValue = calArrayWithReduce(input.arrayDown, lcm)
  let gcdUpValue = calArrayWithReduce(input.arrayUp, gcd)
  
  if gcdUpValue < lcmDownValue {
    return 0
  }
  else if gcdUpValue == lcmDownValue {
    return 1
  }
  
  var count = 0
  for i in lcmDownValue...gcdUpValue {
    if i%lcmDownValue == 0 && gcdUpValue%i == 0 {
      count = count + 1
    }
  }
  return count
}

func printOutput(output: Output) {
  print(output)
}

main()
