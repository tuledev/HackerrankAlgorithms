import Foundation

infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print<T>(any:T) {
    print(any)
}

typealias TestCase = (minAttendance: Int, arrivedTimes: [Int])
typealias Input = ([TestCase])
typealias Output = ([Bool])
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
    let readLineToInt: ()->Int = {
        return Int(readLine()!)!
    }

    let readNTestCase:()->Int = {
        return readLineToInt()
    }

    let readTestCase: () -> TestCase = {
        let infos = readLineToArray()
        let threshold = infos[1]
        let arrivedTimes = readLineToArray()
        return (threshold, arrivedTimes)
    }

    let readTestCases:(Int)->Input = {
        (nTestCase: Int) in
        var testCases = [TestCase]()
        for _ in 0..<nTestCase {
            testCases.append(readTestCase())
        }
        return testCases
    }

    let testCases = readNTestCase |> readTestCases
    return testCases()
}

func excute(input: Input) -> Output {
    var results = Output()

    let checkArrivedOnTime:(Int) -> Bool = {$0 <= 0}

    let countForArrivedOnTime:(Bool) -> Int = {$0 ? 1:0}

    let checkClassIsCanceled:(Int, [Int]) -> Bool = {
        (threshold: Int, arrivedTimes: [Int]) in
        let countOnTime = checkArrivedOnTime |> countForArrivedOnTime
        return threshold > arrivedTimes.reduce(0) { $0 +  countOnTime($1)}
    }

    for testcase in input {
        results.append(checkClassIsCanceled(testcase.minAttendance, testcase.arrivedTimes))
    }

    return results
}

func printOutput(output: Output) {
    for result in output {
        print(result ? "YES" : "NO")
    }
}

main()
