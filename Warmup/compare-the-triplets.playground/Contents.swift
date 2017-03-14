infix operator >> { associativity left }
func >> <T1, T2, T3> (left: (T1)->T2, right: (T2)->T3) -> (T1)->T3 {
    return { (t1: T1) -> T3 in return right(left(t1)) }
}

func readInputArray()
    -> [Int]
{
    return readLine()!.characters.split(" ").map{Int(String($0))!}
}

typealias Input = (arr1:[Int], arr2:[Int])
typealias Result = (triplet1:Int, triplet2:Int)
typealias ReadInput = () -> Input
typealias Excute = (Input) -> Result
typealias Print = (Result) -> Void

func readInput()
    -> Input
{
    let input = readInputArray
//    return (arr1: input(), arr2: input())
    return (arr1: [1,2,3], arr2: [3,2,1])
}

func compareTriplet(input:Input)
    -> Result
{
    var a1 = 0
    var a2 = 0
    
    let arr1 = input.arr1
    let arr2 = input.arr2
    
    for i in 0..<arr1.count {
        if arr1[i] > arr2[i] {
            a1 = a1 + 1
        }
        else if arr2[i] > arr1[i] {
            a2 = a2 + 1
        }
    }
    return (a1, a2);
}

func printResult(result:Result) {
    print(String(result.triplet1) + " " + String(result.triplet2))
}

func main() {
    let input = readInput
    let excute = compareTriplet
    let printR = printResult
    let output = input >> excute >> printR
    output()
}

main()

