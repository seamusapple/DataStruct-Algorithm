//: Playground - noun: a place where people can play

/** 栈和队列也是比较常见的数据结构，它们是比较特殊的线性表.
 *  因为对于栈来说，访问、插入和删除元素只能在栈顶进行，对于队列来说，元素只能从队列尾插入，从队列头访问和删除。
 */

// Stack
struct Stack<Element> {
    var isEmpty: Bool { return stack.isEmpty}
    var size: Int { return stack.count }
    var peek: Element? { return stack.last }
    
    private var stack: [Element] = []
    
    mutating func push(_ newElement: Element) {
        stack.append(newElement)
    }

    mutating func pop() -> Element? {
        return stack.popLast()
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "---Stack---\n"
        let bottomDivider =  "\n-----------\n"
        
        let stackElements = stack.map { "\($0)" }.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}

// Queue
struct Queue<Element> {
    var isEmpty: Bool { return queue.isEmpty }
    var size: Int { return queue.count }
    var peek: Element? { return queue.first }
    
    private var queue = [Element]()
    
    mutating func enqueue(_ newElement: Element) {
        queue.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        if isEmpty {
            return nil
        } else {
            return queue.removeFirst()
        }
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        let topDivider = "---Queue---\n"
        let bottomDivider =  "\n-----------\n"
        
        let queueElements = queue.map { "\($0)" }.joined(separator: "\n")
        return topDivider + queueElements + bottomDivider
    }
}

/**
 下面是 Facebook 一道真实的面试题。
 
 Given an absolute path for a file (Unix-style), simplify it.
 For example,
 path = "/home/", => "/home"
 path = "/a/./b/../../c/", => "/c"
 */

/**
 * 1  . 代表当前路径。比如 /a/. 实际上就是 /a，无论输入多少个 . 都返回当前目录
 * 2  .. 代表上一级目录。比如 /a/b/.. 实际上就是 /a，也就是说先进入 a 目录，再进入其下的 b 目录，再返回 b 目录的上一层，也就是 a 目录。
*/
/**
 * 思路：拆分输入的原路径（根据"/"），返回组成一个栈，遇到字符push，遇到 . 不做操作， 遇到 .. pop
 */
func simplyPath(_ originPath: String) -> String {
    var pathStack = [String]()
    let paths = originPath.split(separator: "/")
    for path in paths {
        let pathString = String.init(path)
        // . 直接省略
        guard pathString != "." else {
            continue
        }
        
        if pathString == ".." {
            pathStack.popLast()
        } else if pathString != "" {
            pathStack.append(pathString)
        }
    }
    
    let ret = pathStack.reduce("", {"\($0)/\($1)"})
    
    return ret.isEmpty ? "/" : ret
}

print(simplyPath("/a/./b/../../c/"))

var rwBookStack = Stack<String>()
rwBookStack.push("3D Games by Tutorials")
rwBookStack.push("tvOS Apprentice")
rwBookStack.push("iOS Apprentice")
rwBookStack.push("Swift Apprentice")
print(rwBookStack)

var rwBookQueue = Queue<String>()
rwBookQueue.enqueue("3D Games by Tutorials")
rwBookQueue.enqueue("tvOS Apprentice")
rwBookQueue.enqueue("iOS Apprentice")
rwBookQueue.enqueue("Swift Apprentice")
print(rwBookQueue)
