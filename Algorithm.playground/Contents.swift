//: Playground - noun: a place where people can play

import UIKit

// 排序
// 1. merge sort 归并算法 时间复杂度 O(nlogn) 空间复杂度O(1)
var array = [7, 2, 6, 3, 9]

func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
    
    let middleIndex = array.count / 2
    
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    
    return merge(leftArray, rightArray)
}

func merge<T: Comparable>(_ leftPile: [T], _ rightPile: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var orderedPile: [T] = []
    
    if orderedPile.capacity < leftPile.count + rightPile.count {
        orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    }
    
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}

mergeSort(array)

// 2. bubble sort 冒泡法 时间复杂度 O(N^2) 空间复杂度O(1)
func bubbleSort<T: Comparable>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else {
        return array
    }
    
    var list = array
    for i in 0..<list.count {
        var j = list.count - 1
        while j > i {
            if isOrderedBefore(list[j], list[j - 1]) {
                let temp = list[j]
                list[j] = list[j - 1]
                list[j - 1] = temp
            }
            j -= 1
        }
    }
    
    return list
}
bubbleSort(array, <)
bubbleSort(array, >)

// 3. insertion sort 插入排序 时间复杂度  O(nlogn) 空间复杂度O(1)
func insertionSort<T: Comparable>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    var list = array
    for i in 1..<list.count {
        var j = i
        while j > 0 {
            if isOrderedBefore(list[j], list[j - 1]) {
                let temp = list[j]
                list[j] = list[j - 1]
                list[j - 1] = temp
                
                j -= 1
            } else {
                break
            }
        }
    }
    return list
}
insertionSort(array, <)
insertionSort(array, >)

// 4. selection sort 选择排序 时间复杂度 O(n^2) 空间复杂度O(1)
func selectionSort<T: Comparable>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else { return array }
    
    var list = array
    for i in 0..<list.count - 1 {
        var j = i + 1
        var minValue = list[i]
        var minIndex = i
        
        while j < list.count {
            if isOrderedBefore(list[j], minValue) {
                minValue = list[j]
                minIndex = j
            }
            j += 1
        }
        
        if minIndex != i {
            let temp = list[i]
            list[i] = list[minIndex]
            list[minIndex] = temp
        }
    }
    
    return list
}
selectionSort(array, <)
selectionSort(array, >)

// 5. binary search 二分查找 时间复杂度 O(logn) 空间复杂度 O(1)
func binarySearch<T: Comparable>(_ array: [T], target: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    } else {
        let midleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        
        if array[midleIndex] < target {
            return binarySearch(array, target: target, range: midleIndex + 1 ..< range.upperBound)
        } else if array[midleIndex] > target {
            return binarySearch(array, target: target, range: range.lowerBound ..< midleIndex)
        } else {
            return midleIndex
        }
    }
}

array = mergeSort(array)

binarySearch(array, target: 7, range: 0..<array.count)

func binarySearch<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}
binarySearch(array, key: 7)
