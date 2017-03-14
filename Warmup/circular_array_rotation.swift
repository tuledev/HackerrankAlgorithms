import Foundation

infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print(any:Any) {
//    print(any)
}

typealias Input = (nRotate: Int, array:[Int], queries:[Int])
typealias Output = ([Int])
typealias Excute = Input -> Output
typealias Print = Output -> Void

func main() {
    let input = readInput
    let output = excute
    let printOut = printOutput
    let run = input |> output |> printOut
    run()
}

func readInput() -> Input {
    let readLineToArray: ()->[Int] = {
        return readLine()!.characters.split(" ").map{Int(String($0))!}
    }
    let infos = readLineToArray()
    let nRotate = infos[1]

    let array = readLineToArray()

    let nQueries = infos[2]
    var queries = [Int]()
    for _ in 0..<nQueries {
        queries.append(readLineToArray()[0])
    }

    return (nRotate, array, queries)
}

func excute(input: Input) -> Output {
    let checkValidIndex:([Int], Int) -> Bool = {
        (array: Array, index:Int) in
        return (index >= 0 && index <= array.count-1)
    }
    let moveElementFromNToM:([Int], Int, Int)->[Int] = {
        (var array:Array, from:Int, to:Int) in
        if (checkValidIndex(array, from) && checkValidIndex(array, to)) {
            let element = array[from]
            array.removeAtIndex(from)
            array.insert(element, atIndex: to)
        }
        else {
            /// invalid index
        }
        return array
    }
    let moveNFirstElementToFirst: ([Int], Int) -> [Int] = {
        (array:Array, from:Int) in
        var result = [Int]()
        if (checkValidIndex(array, from)) {
            let subArray = Array(array[from...array.count-1])
            DEBUG_print(subArray)
            let remandArray = Array(array[0..<from])
            DEBUG_print(remandArray)
            result = subArray + remandArray
        }
        else {
            result = array
        }
        return result
    }
    let rotateNTime:([Int], Int)->[Int] = {
        (array:Array, nRotate:Int) in
        var rotatedArray = array
        let reducedNRotate = nRotate % rotatedArray.count
//        for _ in 0..<reducedNRotate {
//            rotatedArray = moveElementFromNToM(rotatedArray,
//                                                rotatedArray.count-1, 0)
//            DEBUG_print(rotatedArray)
//        }
        rotatedArray = moveNFirstElementToFirst(rotatedArray, rotatedArray.count - reducedNRotate)
        return rotatedArray
    }

    var rotatedArray = input.array
    rotatedArray = rotateNTime(rotatedArray, input.nRotate)

    let valuesAtIndexs:([Int], [Int]) -> [Int] = {
        (array:Array, queries:[Int]) in
        var results = [Int]()
        for i in 0..<queries.count {
            if (checkValidIndex(array, queries[i])) {
                results.append(array[queries[i]])
            }
        }
        return results
    }
    DEBUG_print(input.queries)
    DEBUG_print(rotatedArray)
    return valuesAtIndexs(rotatedArray, input.queries)
}

func printOutput(output: Output) {
    let _ = output.map(){ print($0) }
}

main()
