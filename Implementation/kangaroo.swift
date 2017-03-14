import Foundation

infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

func DEBUG_print(any:Any) {
    print(any)
}

typealias Input = (start1: Int, speed1: Int, start2: Int, speed2: Int)
typealias Output = (Bool)
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

    let inputs = readLineToArray()
    return (inputs[0], inputs[1], inputs[2], inputs[3])
}

func excute(input: Input) -> Output {
    var output = true

    let diffStart = input.start1 - input.start2
    let diffSpeed = input.speed1 - input.speed2

    let checkTooFast:(Int, Int) -> Bool = {
        (diffStart: Int, diffSpeed: Int) in
        if (diffSpeed == 0 && diffStart == 0) {
            return false
        }
        else if (diffStart * diffSpeed == 0) {
            return true
        }
        else if (diffStart * diffSpeed > 0) {
            return true
        }
        return false
    }

    if checkTooFast(diffStart, diffSpeed) {
        output = false
    }
    else {
        let checkAIsDibisorOfB:(Int, Int) ->Bool = {
            (A: Int, B: Int) in
            if B%A == 0 {
                return true
            }
            return false
        }

        if checkAIsDibisorOfB(diffSpeed, diffStart) {
            output = true
        }
        else {
            output = false
        }
    }
    return output
}

func printOutput(output: Output) {
    output ? print("YES"):print("NO")
}

main()
