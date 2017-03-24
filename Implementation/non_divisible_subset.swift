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

struct Graph {
  typealias EDGES = [String: Bool]
  private var _edges = EDGES()
  init(array:[Int], divideNum:Int) {
    _edges = createGraph(array: array, divideNum: divideNum, keyConverter: keyFromVertexs)
  }
  
  private func createGraph(array:[Int], divideNum: Int, keyConverter:(Int,Int)->String) -> EDGES {
    var edges = EDGES()
    for idx1 in 0...array.count-2 {
      for idx2 in idx1...array.count-1 {
        let vertex1 = array[idx1]
        let vertex2 = array[idx2]
        if ((vertex1 + vertex2) % divideNum != 0) {
          edges[keyConverter(vertex1, vertex2)] = true
        }
      }
    }
    return edges
  }
  
  private func keyFromVertexs(vertex1: Int, vertex2: Int) -> String {
    return vertex1>vertex2 ? "\(vertex1)" + "-" + "\(vertex2)" : "\(vertex2)" + "-" + "\(vertex1)"
  }
  
  func edgeBetween(_ vertex1: Int,_ vertex2: Int) -> Bool {
    return _edges[keyFromVertexs(vertex1: vertex1, vertex2: vertex2)] == nil ? false : true
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

typealias Input = (divideNum: Int, array:[Int])
typealias Output = (Int)

solve(input: {
  let divideNum = Utils.readLineToArray()[1]
  return (divideNum, Utils.readLineToArray())
},
      output: {
        (result: Output) in
        print(result)
}) {
  (input: Input) in
  
  let graph = Graph.init(array: input.array, divideNum: input.divideNum)
  
  func maxLenghtSubsets(subsets:[[Int]]) -> Int {
    let lengthSubsets = subsets.map() {$0.count}
    return lengthSubsets.max()!
  }
  
  func clique(array:[Int], graph: Graph, fullArray: [Int]) -> [[Int]] {
    if array.count == 0 {
      return [[]]
    }
    
    let cutFirstArray = array.count > 1 ? Array(array[1...(array.count-1)]) : []
    let subsets = clique(array:cutFirstArray, graph: graph, fullArray: fullArray)
    
    let updatedSubsets = subsets.reduce([[Int]]()) {
      (result, subArray) in
      if subArray.count >= 1 {
        for vertex in subArray {
          if graph.edgeBetween(vertex, array[0]) == false {
            return result
          }
        }
      }
      
      return result + [subArray + [array[0]]]
    }
    
    let result = subsets + updatedSubsets
    
    func reduceSubset(subs:[[Int]], remanding: Int) -> [[Int]] {
      if remanding == 0 {
        return subs
      }
      
      let maxLengthSubs = maxLenghtSubsets(subsets:subs)
      return subs.reduce([[Int]]()) {
        (result, sub) in
        if (maxLengthSubs - sub.count) >= remanding {
          return result
        }
        return result + [sub]
      }
    }
    let reduced = reduceSubset(subs: result, remanding: fullArray.count - array.count)
    return reduced
  }
  
  let allCliques = clique(array: input.array, graph: graph, fullArray: input.array)
  return maxLenghtSubsets(subsets:allCliques)
}








