import Foundation

infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print(any:Any) {
    print(any)
}

typealias Input = (String)
typealias Output = (String)
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
    let n = readLine()!
    return n
}

func excute(input: Input) -> Output {
    var output = ""

    typealias InputUnits = (hour: String, minute: String, second: String, am: String)
    typealias OutputUnits = (hour: String, minute: String, second: String)

    let splitStringToUnits: (String)->InputUnits = {
        (timeString: String) in
        let hMS = timeString.componentsSeparatedByString(":")

        let secondAMPM:String = hMS[2]
        let amPM = secondAMPM.substringFromIndex(secondAMPM.endIndex.advancedBy(-2))
        let second = secondAMPM.substringToIndex(secondAMPM.startIndex.advancedBy(2))

        return (hour: hMS[0], minute: hMS[1], second: second, am: amPM)
    }

    let inputUnitsToOutputUnit: (InputUnits)->OutputUnits = {
        (inputUnits:InputUnits) in
        var outputUnits = OutputUnits(hour:"", minute:"", second:"")
        if inputUnits.hour == "12" {
            outputUnits.hour = "00"
        }
        else {
            outputUnits.hour = inputUnits.hour
        }
        if inputUnits.am == "PM" {
            outputUnits.hour = String(Int(outputUnits.hour)! + 12)
        }
        else {
        }

        outputUnits.minute = inputUnits.minute
        outputUnits.second = inputUnits.second

        return outputUnits
    }

    let outputUnitsToString: (OutputUnits)->String = {
        (outputUnits: OutputUnits) in
        return "\(outputUnits.hour):\(outputUnits.minute):\(outputUnits.second)"
    }

    let process =  splitStringToUnits |> inputUnitsToOutputUnit |> outputUnitsToString
    output = process(input)

    return output
}

func printOutput(output: Output) {
    print(output)
}

main()
