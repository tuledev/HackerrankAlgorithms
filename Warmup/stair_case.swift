import Foundation

infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

typealias Input = (Int)
typealias Output = ([String])
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
    return n
}

func excute(input: Input) -> Output {
    var output:Array = [String]()
    for i in 0..<input {
        var line = ""
        for j in 0..<input {
            if j < input-1-i {
                line = line + " "
            }
            else {
                line = line + "#"
            }
        }
        output.append(line)
    }
    return output
}

func printOutput(output: Output) {
    for i in 0..<output.count {
        print(output[i])
    }
}

main()
