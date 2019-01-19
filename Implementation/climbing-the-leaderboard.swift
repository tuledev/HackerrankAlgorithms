import Foundation

func removeDuplicates<Element: Equatable>(array: [Element]) -> [Element]{
    var result = [Element]()
    for value in array {
        if !result.contains(value) {
            result.append(value)
        }
    }
    return result
}

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
  let data = input()
    let result = excute(data)
    output(result)
//  let run = input |> excute |> output
//  run()
}


func searchIndexBinary(_ array: [Int], key: Int, startIndex: Int = 0, endIndex: Int = 0) -> Int {
    print("key", key)
    print("array", array)
    if array.count == 1 {
        print("endIndex", endIndex)
        print("startIndex", startIndex)
        if key > array[0] { return startIndex }
        else if key == array[0] { return startIndex }
        else { return startIndex + 1 }
    }
    
    let midIndex = array.count/2
    if key > array[midIndex] {
        let sliceArray = Array(array.prefix(midIndex))
        return searchIndexBinary(sliceArray, key: key, startIndex: startIndex, endIndex: startIndex + midIndex)
    }
    else if key < array[midIndex] {
        let sliceArray = Array(array.suffix(array.count - midIndex))
        return searchIndexBinary(sliceArray, key: key, startIndex: startIndex + midIndex, endIndex: endIndex)
    }
    else {
        return startIndex + midIndex
    }
}

func searchLinear(_ array: [Int], key: Int, endIndex: Int) -> Int {
    if endIndex == 0 { return 0 }
    let lastIndex = endIndex - 1
    if key < array[lastIndex] { return endIndex }
    for index in (0..<lastIndex).reversed() {
        if key < array[index] { return index + 1 }
    }
    
    if key >= array[0] {
        return 0
    }
    
    return lastIndex
}
//1
//100
//1
//102
// Complete the climbingLeaderboard function below.
func climbingLeaderboard(scores: [Int], alice: [Int]) -> [Int] {
    let removedDupScores = removeDuplicates(array: scores)
    var rankingResults = [Int]()
    var previousRank = removedDupScores.count + 1
    var previousValue = -1
    for aliceScore in alice {
        var ranking = 0
        if previousValue == aliceScore {
            ranking = previousRank
        }
        else {
            ranking = searchLinear(removedDupScores,
                                   key: aliceScore,
                                   endIndex: previousRank - 1) + 1
        }
        rankingResults.append(ranking)
        previousRank = ranking
        previousValue = aliceScore
    }
    return rankingResults
}


solve(input: {
        return (Utils.readLineToInt(), Utils.readLineToArray(), Utils.readLineToInt(), Utils.readLineToArray())
      },
      output: {
        (result: [Int]) in
        print("result", result)
      }) {
        let scores = $0.1
        let aliceScores = $0.3

        let result = climbingLeaderboard(scores: scores, alice: aliceScores)
        return result
}

