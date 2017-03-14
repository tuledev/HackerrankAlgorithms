import Foundation

infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

typealias Input = ([Int])
typealias Output = (positive: Double, negative: Double, zero: Double)
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
    /// n
    let n = Int(readLine()!)!

    var input: Input = []
    input = readLine()!.characters.split(" ").map{Int(String($0))!}
    return input
}

func excute(input: Input) -> Output {
    var positiveCount = 0.0
    var negativeCount = 0.0
    var zeroCount = 0.0
    for i in 0..<input.count {
        if input[i] > 0 {
            positiveCount = positiveCount + 1
        }
        else if input[i] < 0 {
            negativeCount = negativeCount + 1
        }
        else {
            zeroCount = zeroCount + 1
        }
    }
    let n = Double(input.count)
    return (positiveCount/n, negativeCount/n, zeroCount/n)
}

func printOutput(output: Output) {
    let round6 = {
        (value:Double) in
        return Double(Int(round(value*1000000)))/1000000.0
        }
    print(round6(output.positive))
    print(round6(output.negative))
    print(round6(output.zero))
}

main()
