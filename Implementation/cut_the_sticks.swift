import Foundation

infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
    print(any)
}

typealias Input = ([Int])
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
    readLineToArray()
    return readLineToArray()
}

func excute(input: Input) -> Output {
    var results = [Int]()

    let countRemaining:([Int]) -> Int = {$0.count}
    let minValueInArray:([Int]) -> Int = {$0.reduce(-1){(($0<$1 && $0>0) ? $0:$1)}}
    let reduceArrayByValue:([Int], Int) -> [Int] = {
        (array:[Int], reduceValue: Int) in
//        let reducedResults = array.reduce([Int]()){
//            (var results: [Int], value: Int) in
//            let reducedValue = value - reduceValue
//            if reducedValue > 0 { results.append(reducedValue) }
//            return results
//        }
        let reducedResults = array.map() { $0 - reduceValue }.filter() {$0 != 0}
        return reducedResults
    }

    let cutArrayToNil:([Int]) -> [Int] = {
        var results = [Int]()

        var remainArray = $0
        results.append(countRemaining(remainArray))
        while ( remainArray.count > 0 ) {
            remainArray = reduceArrayByValue(remainArray, minValueInArray(remainArray))
            if (remainArray.count > 0) { results.append(countRemaining(remainArray))}
        }
        return results
    }

    return cutArrayToNil(input)
}

func printOutput(output: Output) {
    output.map(){print($0)}
}

main()
