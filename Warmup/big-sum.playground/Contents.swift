infix operator >> { associativity left }
func >> <T1, T2, T3> (left: (T1)->T2, right: (T2)->T3) -> (T1)->T3 {
    return { (t1: T1) -> T3 in return right(left(t1)) }
}

func readInputArray()
    -> [Int]
{
    return readLine()!.characters.split(" ").map{Int(String($0))!}
}

typealias Input = ([Int])
typealias Result = (Int)
typealias Excute = (Input) -> Result
typealias Print = (Result) -> Void

func readInput()
    -> Input
{
    let input = readInputArray
//    return (arr: input())
    return (arr1: [1,2,3])
}

func compareTriplet(input:Input)
    -> Result
{
    var sum = 0
    
    let arr = input
    
    for i in 0..<arr.count {
        sum = sum + arr[i]
    }
    return (sum);
}

func printResult(result:Result) {
    print(String(result))
}

func main() {
    let input = readInput
    let excute = compareTriplet
    let printR = printResult
    let output = input >> excute >> printR
    output()
}

main()

