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

typealias Input = (String)
typealias Output = (String)

solve(input: {
  return Utils.readLineToString()
},
      output: {
        (result: Output) in
        print(result)
}) {
  (input: Input) in
  let nColumns = Int(ceil(sqrt(Double(input.characters.count))))
  var nRows = Int(floor(sqrt(Double(input.characters.count))))
  if (nRows*nColumns < input.characters.count) {
    nRows = nRows + 1
  }
  func encrypte(string: String, step: Int, jump: Int,
                remanding: Int, curResult: String) -> String {
    if remanding == 0 {
      return String(curResult.characters.dropLast(1))
    }
    
//    func wordFrom(string: String, step: Int, jump: Int,
//                  remanding: Int) {
      let word = (0..<step).reduce("") {
        let position = $1*jump + (jump - remanding)
        if (position >= string.characters.count) {  return $0 }
        return $0 + String(string[string.index(string.startIndex,
                                               offsetBy:position)])
      }
//      return word
//    }
    
    return encrypte(string: string, step: step, jump: jump,
                    remanding: remanding - 1, curResult: curResult + word + " ")
  }
  
  return encrypte(string: input, step: nRows, jump: nColumns, remanding: nColumns, curResult: "")
}
