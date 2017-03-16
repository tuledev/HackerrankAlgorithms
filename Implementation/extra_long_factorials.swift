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


struct BigInt {
  let value: String!
  
  static func *(left: BigInt, right: BigInt) -> BigInt {
    let num_1 = left.value.characters.reversed().map() {Int(String($0))!}
    let num_2 = right.value.characters.reversed().map() {Int(String($0))!}
    
    var result = [Int](repeating: 0, count: num_1.count+num_2.count)
    
    for (idx_1, digit_1) in num_1.enumerated() {
      for (idx_2, digit_2) in num_2.enumerated() {
        let idx = idx_1 + idx_2
        
        result[idx] = digit_1*digit_2 + result[idx]
        
        if result[idx] > 9 {
          result[idx+1] = result[idx]/10 + result[idx+1]
          result[idx] = result[idx]%10
        }
      }
    }
    
    let reversedResult = Array(result.reversed())
    var startIdx = reversedResult.enumerated().reduce(-1) {
      (result, element) in
      if result == -1 && element.1 != 0 { return element.0 }
      return result
    }
    startIdx = (startIdx == -1 ) ? 0 : startIdx
    result = Array(reversedResult[startIdx...reversedResult.count-1])
    
    return BigInt(value: result.map(){String($0)}.joined(separator:"") )
  }
}

  
solve(input: {
        return Utils.readLineToInt()
      },
      output: {
        (result: BigInt) in
        print(result.value)
      }) {
        func factoryOfN(remainding: Int, result: BigInt) -> BigInt {
          if remainding == 1 { return result }
          else {
            let multiResult = BigInt(value: String(remainding-1)) * result
            return factoryOfN(remainding: remainding-1, result: multiResult)
          }
        }
        return factoryOfN(remainding: $0, result: BigInt(value:String($0)))}
