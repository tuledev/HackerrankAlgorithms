import Foundation

infix operator |> : AdditionPrecedence
func |> <T1, T2, T3> (left: @escaping (T1)->T2, right: @escaping (T2)->T3) -> (T1) -> T3 {
  return { (t1:T1) -> T3 in return right(left(t1))}
}

struct Utils {
  
  static func readLineToArray()->[Int] {
    return readLine()!.components(separatedBy:" ").map{Int(String($0))!}
  }
  
  static func readLineToTuple()->(Int, Int) {
    let input = readLineToArray()
    return (input[0], input[1])
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

typealias Position = (Int, Int)
typealias Input = (lenghtBoard: Int, queen:Position, obstacles:[Position])
typealias Output = (Int)

solve(input: {
  let input1 = Utils.readLineToArray()
  let lenghtBoard = input1[0]
  let input2 = Utils.readLineToArray()
  let queen = (input2[0], input2[1])
  
  func readObstacles(remanding: Int, currentResult:[Position]) -> [Position] {
    var result = currentResult
    for _ in 0..<remanding {
        result = result + [Utils.readLineToTuple()]
    }
    return result
  }
  let obstaclePositions = readObstacles(remanding: input1[1], currentResult: [Position]())
  return (lenghtBoard, queen, obstaclePositions)
},
      output: {
        (result: Output) in
        print(result)
}) {
  (input: Input) in
  let queen = input.queen
  
  let topDead = input.lenghtBoard + 1
  let bottomDead = 0
  
  let roundDead: (Int)->Int = {
    if $0 > topDead {
      return topDead
    }
    else if $0 < bottomDead {
      return bottomDead
    }
    return $0
  }
  let roundPosition: (Position)->Position = { return (roundDead($0.0), roundDead($0.1)) }
  
  let leftTopObstacle = roundPosition((queen.0 + queen.1 - bottomDead,
                                       queen.0 + queen.1 - topDead))
  let topObstacle = roundPosition((topDead,
                                   queen.1))
  let rightTopObstacle = roundPosition((queen.0 - queen.1 + topDead,
                                        queen.1 - queen.0 + topDead))
  let rightObstacle = roundPosition((queen.0,
                                     topDead))
  let rightBottomObstacle = roundPosition((queen.0 + queen.1 - topDead,
                                           queen.0 + queen.1 - bottomDead))
  let bottomObstacle = roundPosition((bottomDead,
                                      queen.1))
  let leftBottomObstacle = roundPosition((queen.0 - queen.1 + bottomDead,
                                          queen.1 - queen.0 + bottomDead))
  let leftObstacle = roundPosition((queen.0,
                                    bottomDead))
  
  var realObstacles = [leftTopObstacle,
                       topObstacle,
                       rightTopObstacle,
                       rightObstacle,
                       rightBottomObstacle,
                       bottomObstacle,
                       leftBottomObstacle,
                       leftObstacle]
  
  func length(from point1:Position, to point2: Position) -> Int {
    let row = abs(point1.0 - point2.0) - 1
    let colume = abs(point1.1 - point2.1) - 1
    return row > colume ? row : colume
  }
  
  var currentLengths = realObstacles.map() { length(from: input.queen, to: $0) }
  
  enum Direction: Int {
    case LeftTop
    case Top
    case RightTop
    case Right
    case RightBottom
    case Bottom
    case LeftBottom
    case Left
    case None
    
    static func kindOf(position: Position, withQueen queen:Position) -> Direction {
      if position.0 == queen.0 {
        if position.1 > queen.1 { return .Right }
        else { return .Left }
      }
      else if position.1 == queen.1 {
        if position.0 > queen.0 { return .Top }
        else { return .Bottom }
      }
      else if abs(position.0 - queen.0) == abs(position.1 - queen.1) {
        if position.0 > queen.0 {
          if position.1 < queen.1 { return .LeftTop }
          else { return .RightTop }
        }
        else {
          if position.1 > queen.1 { return .RightBottom }
          else { return .LeftBottom }
        }
      }
      return .None
    }
  }
  
  let uniqObstacles = input.obstacles.reduce([Position]()) {
    (result, elem) in
    if result.contains(where: {elem.0 == $0.0 && elem.1 == $0.1 }) {
      return result
    }
    return result + [elem]
  }
  
  let updateRealObstacles:(Position) -> () = {
    let type = Direction.kindOf(position: $0, withQueen: input.queen)
    if type != .None {
      let lengthToQueen = length(from: $0, to: input.queen)
      if lengthToQueen < currentLengths[type.rawValue] {
        currentLengths[type.rawValue] = lengthToQueen
        realObstacles[type.rawValue] = $0
      }
    }
  }
  
  uniqObstacles.forEach() { updateRealObstacles($0) }
  
  return realObstacles.reduce(0) { $0 + length(from: input.queen, to: $1) }
}
