//: Playground - noun: a place where people can play

import UIKit

// LinerList
/**
 线性表是最常用且最简单的一种数据结构，它是 n 个数据元素的有限序列。
 
 实现线性表的方式一般有两种，一种是使用数组存储线性表的元素，即用一组连续的存储单元依次存储线性表的数据元素。另一种是使用链表存储线性表元素，即用一组任意的存储单元存储线性表的数据元素（存储单元可以是连续的，也可以是不连续的）。
 */

// Array
/**
 数组是一种大小固定的数据结构，对线性表的所有操作都可以通过数组来实现。虽然数组一旦创建之后，它的大小就无法改变了，但是当数组不能再存储线性表中的新元素时，我们可以创建一个新的大的数组来替换当前数组。这样就可以使用数组实现动态的数据结构。
 */

// LinkList
/**
 链表是一种物理存储单元上非连续、非顺序的存储结构，数据元素的逻辑顺序是通过链表中的指针链接次序实现的。链表由一系列节点组成，这些节点不必在内存中相连。每个节点由数据部分 Data 和链部分 Next，Next 指向下一个节点，这样当添加或者删除时，只需要改变相关节点的 Next 的指向，效率很高。
 */
// 定义一个链表的节点，使用class引用类型而不是struct结构体是因为结构体不能存储自身类型的属性
class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    public func description() {
        var printNext = next
        var descriptionString = "\(val)"
        while printNext != nil {
            descriptionString += " -> " + "\(printNext!.val)"
            printNext = printNext!.next
        }
        print(descriptionString)
    }
}

// 定义一个链表类
class LinkList {
    var head: ListNode?
    var tail: ListNode?
    
    // 尾插法
    public func appendToTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        } else {
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }
    
    // 头插法
    public func insertAtHead(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let newHead = ListNode(val)
            newHead.next = head
            head = newHead
        }
    }
}

/**
 * 功能：以给定值 x 为基准将链表分割成两部分，所有小于 x 的结点排在大于或等于 x 的节点之前。
 * 例：1->5->3->2->4->2，给定 x = 3。则我们要返回 1->2->2->5->3->4
 */
func partition(_ linkList: LinkList?, base x: Int) -> ListNode? {
    if linkList == nil {
        return nil
    }
    
    var node: ListNode? = linkList!.head!
    let beforeLinkList = LinkList()
    let afterLinkList = LinkList()
    
    while node != nil {
        if node!.val < x {
            beforeLinkList.appendToTail(node!.val)
        } else {
            afterLinkList.appendToTail(node!.val)
        }
        
        node = node!.next
    }
    
    beforeLinkList.tail!.next = afterLinkList.head
    return beforeLinkList.head!
}

var originLinkList = LinkList()
originLinkList.appendToTail(1)
originLinkList.appendToTail(5)
originLinkList.appendToTail(3)
originLinkList.appendToTail(2)
originLinkList.appendToTail(4)
originLinkList.appendToTail(2)
//let retLinkList = partition(originLinkList, base: 3)
//retLinkList!.description()

// 检查链表是否有环
func hasCycle(_ linklist: LinkList?) -> Bool {
    if linklist != nil {
        return false
    }
    
    var slow = linklist!.head
    var fast = linklist!.head
    
    while slow != nil && fast != nil {
        slow = slow!.next
        fast = fast!.next!.next
        
        if slow === fast {
            return true
        }
    }
    return false
}

// 链表删除节点
// 删除链表中倒数第 n 个节点。例：1->2->3->4->5，n = 2。返回 1->2->3->5。
// 注意：给定 n 的长度小于等于链表的长度。
func removeNthFromEnd(_ head: ListNode?, n: Int) -> ListNode? {
    guard let head = head else {
        return nil
    }
    
    let dummy = ListNode(0)
    dummy.next = head
    var prev: ListNode? = dummy
    var post: ListNode? = dummy
    
    for _ in 0..<n {
        if post == nil {
            break
        }
        
        post = post!.next
    }
    
    while post != nil && post!.next != nil {
        prev = prev!.next
        post = post!.next
    }
    
    prev!.next = prev!.next?.next
    
    return dummy.next
}

// 倒序遍历链表
func printListRev(_ head: ListNode?) {
    var description = ""
    if (head != nil) {
        printListRev(head!.next)
        print(head!.val)
    }
}

func printList(_ head: ListNode?) {
    guard var headVar = head else {
        return
    }
    var description = "\(headVar.val)"
    while headVar.next != nil {
        description += "-> " + "\(headVar.next!.val)"
        headVar = headVar.next!
    }
    print(description)
}

printList(originLinkList.head)
printListRev(originLinkList.head)

