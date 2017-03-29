import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

struct Utils {
  
  static func readLineToArray()->[Int] {
    return readLine()!.components(separatedBy:" ").map{Int(String($0))!}
  }
  
  static func readLineToInt()->Int {
    return Int(readLine()!)!
  }
  
  static func readLineToString() -> String {
    return readLine()!
  }
}

func solve<Input, Output> (
  input: @escaping ()->Input,
  output: @escaping (Output)->(),
  excute: @escaping (Input)->Output)
{
  let run = input |> excute |> output
  run()
}

typealias Input = ([Int])
typealias Output = (Int)

solve(input: {
  Utils.readLineToInt()
  return (Utils.readLineToArray())
},
      output: {
        (result: Output) in
        print(result)
}) {
  (input: Input) in
  
  func jump(currentPosition: Int, clouds:[Int], totalStep: Int) -> Int {
    if (currentPosition >= clouds.count - 1) {
      return totalStep
    }
    
    var nextPosition = currentPosition + 2
    if nextPosition > clouds.count - 1 || clouds[nextPosition] == 1 {
      nextPosition = nextPosition - 1
    }
    return jump(currentPosition: nextPosition, clouds: clouds, totalStep: totalStep + 1)
  }
  
  return jump(currentPosition: 0, clouds: input, totalStep: 0)
}
