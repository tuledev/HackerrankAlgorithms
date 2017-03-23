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
//  run()
}

typealias Input = (divideNum: Int, array:[Int])
typealias Output = (Int)

//solve(input: {
//  return Utils.readLineToArray() 
//},
//      output: {
//        (result: Output) in
//        print(result)
//}) {
//  (input: Input) in
//  
//  let createGraph:([Int])->[String:Bool] = {
//    
//  }
//  
//  func clique(array:[Int]) -> Int {
//    if array.count == 0 {
//      return [[]]
//    }
//    
//    let cutFirstArray = array.count > 1 ? Array(array[1...(array.count-1)]) : []
//    let subsets = powerset(array:cutFirstArray)
//    
//    let updatedSubsets = subsets.map() { $0 + [array[0]] }
//    
//    return subsets + updatedSubsets
//  }
//  
//}

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

let graph = Graph(array:[1,7,2,4], divideNum: 3)

print(graph.edgeBetween(1,7))
print(graph.edgeBetween(2,7))
print(graph.edgeBetween(7,2))
print(graph.edgeBetween(7,4))
print(graph.edgeBetween(4,2))


















