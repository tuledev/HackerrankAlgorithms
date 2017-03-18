import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

struct Utils {
  
  static func readLineToArray()->[Int] {
    return readLine()!.components(separatedBy:" ").map{Int(String($0))!}
  }
  
  static  func readLineToInt()->Int {
    return Int(readLine()!)!
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

typealias DATE = (day: Int, month: Int, year: Int)
typealias Input = (returnedDate: DATE, expectedDate: DATE)
typealias Output = Int

solve(input: {
  let input1 = Utils.readLineToArray()
  let input2 = Utils.readLineToArray()
  
  return ((day:input1[0], month:input1[1], year:input1[2]),
          (day:input2[0], month:input2[1], year:input2[2]))
},
      output: {
        (result: Output) in
        print(result)
}) {
  (input: Input) in
  let fees:[(Int)->Int] = [{$0*15}, {$0*500}, {_ in 10_000}]
  
  var fee:((Int)->Int) = fees[0]
  var diff:Int = 0
  
  let yearDiff = input.returnedDate.year - input.expectedDate.year
  let monthDiff = input.returnedDate.month - input.expectedDate.month
  let dayDiff = input.returnedDate.day - input.expectedDate.day
  
  if yearDiff > 0 {
    fee = fees[2]
    diff = yearDiff
  }
  else if yearDiff == 0 && monthDiff > 0 {
    fee = fees[1]
    diff = monthDiff
  }
  else if yearDiff == 0 && monthDiff == 0 && dayDiff > 0 {
    fee = fees[0]
    diff = dayDiff < 0 ? 0 : dayDiff
  }
  
  return fee(diff)
}
