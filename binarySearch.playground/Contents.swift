import UIKit


let numbers = [3, 6, 8, 9, 11, 13, 15, 17, 22]

func binarySearch(searchValue: Int, array: [Int]) -> Bool {
    
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex <= rightIndex {
        let midIndex = (leftIndex + rightIndex) / 2
        let midValue = array[midIndex]
        print("midIndex: \(midIndex), midValue: \(midValue), leftIndex: \(leftIndex), rightIndex: \(rightIndex)")
        if midValue == searchValue {
        return true
    }
        if searchValue > midValue {
        leftIndex = midIndex + 1
       }
    
        if searchValue < midValue {
        rightIndex = midIndex - 1
    }
  }
    return false
}

print(binarySearch(searchValue: 22, array: numbers))

