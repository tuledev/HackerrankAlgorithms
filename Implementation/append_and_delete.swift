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

solve(input: {
        return (readLine()!, readLine()!, Utils.readLineToInt())
      },
      output: {
        (result: Bool) in
        result ? print("Yes") : print("No")
      }) {
        let s = $0.0
        let t = $0.1
        let numOfOperations = $0.2
        
        if s.characters.count + t.characters.count <= numOfOperations {
          return true
        }
        else {
          let diffIdx: (_ sourceChars: [Character],_ targetChars: [Character]) -> Int = {
            (sourceChars, targetChars) in
            
            let minLenght = (sourceChars.count < targetChars.count) ?
              sourceChars.count : targetChars.count
            
            func diffIdxFrom(currentIdx: Int, endIdx: Int,
                             source: [Character], target: [Character])
              -> Int {
                if currentIdx == endIdx || source[currentIdx] != target[currentIdx] {
                  return currentIdx
                }
                return diffIdxFrom(currentIdx: currentIdx+1, endIdx: endIdx,
                                   source: source, target: target)
            }
            return diffIdxFrom(currentIdx: 0, endIdx: minLenght-1,
                               source: sourceChars , target: targetChars)
          }
          let sourceChars = Array(s.characters)
          let targetChars = Array(t.characters)
          let diff = diffIdx(sourceChars, targetChars)
          
          let requiredStep = ((sourceChars.count-1) - diff + 1) + ((targetChars.count-1) - diff + 1)
          if numOfOperations >= requiredStep && (numOfOperations - requiredStep) % 2 == 0 {
            return true
          }
        }
        return false
}
