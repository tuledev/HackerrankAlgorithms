import Foundation

infix operator |> {associativity left}
func |> <T1, T2, T3> (left:(T1)->T2, right:(T2)->T3) -> (T1) -> T3 {
    return { (t1:T1) -> T3 in return right(left(t1))}
}

func filterPairElementInArray<T,V>(array:[T], transform:(T,T)->V?) -> [V] {
    var results = [V]()
    for i in 0..<array.count-1 {
        for j in (i+1)..<array.count {
            if let result = transform(array[i], array[j]) {
                results.append(result)
            }
        }
    }
    return results
}

func DEBUG_print<T>(any:T) {
    print(any)
}

typealias Input = (divisibleK: Int, array:[Int])
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
    let readLineToArray: ()->[Int] = {
        return readLine()!.characters.split(" ").map{Int(String($0))!}
    }

    let infos = readLineToArray()
    let array = readLineToArray()
    return (infos[1], array)
}

func excute(input: Input) -> Output {
    let sum:(Int, Int) -> Int = { $0 + $1 }
    let checkADivisibleB: (Int, Int) -> Bool = { $0 % $1 == 0 }

    let pairs:[(Int, Int)] = filterPairElementInArray(input.array) {
        if checkADivisibleB(sum($0, $1), input.divisibleK) {
            return ($0, $1)
        }
        return nil
    }

    return pairs.count
}

func printOutput(output: Output) {
    print(output)
}

main()
