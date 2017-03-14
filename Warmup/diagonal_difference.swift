infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

typealias Input = ([[Int]])
typealias Output = (Int)
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
    for _ in 0..<n {
       input.append(readLine()!.characters.split(" ").map{Int(String($0))!})
    }
    return input
}

func excute(input: Input) -> Output {
    var primary = 0
    var secondary = 0
    for i in 0..<input.count {
        primary = primary + input[i][i]
        secondary = secondary + input[i][input.count - 1 - i]
    }
    let output = abs(primary - secondary)
    return output
}

func printOutput(output: Output) {
    print(output)
}

main()
