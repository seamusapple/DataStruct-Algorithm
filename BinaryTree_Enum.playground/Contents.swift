//: Playground - noun: a place where people can play

import UIKit

// 树
/**
 *  树 是由 n（n>=1）个有限节点组成一个具有层次关系的集合。
 *  它具有以下特点：每个节点有零个或多个子节点；没有父节点的节点称为 根 节点；每一个非根节点有且只有一个 父节点；
 *  除了根节点外，每个子节点可以分为多个不相交的子树
 */

// 二叉树
/**
 *  二叉树是每个节点最多有两棵子树的树结构。通常子树被称作 “左子树” 和 “右子树”。二叉树常被用于实现二叉查找树和二叉堆。
 *  二叉树的每个结点至多只有 2 棵子树 (不存在度大于 2 的结点)，二叉树的子树有左右之分，次序不能颠倒。
 
 *  二叉树的第 i 层至多有 2^(i-1) 个结点；深度为 k 的二叉树至多有 2^k - 1 个结点。
 
 *  一棵深度为 k，且有 2^k-1 个节点的二叉树称之为 满二叉树 ；
 
 *  深度为 k，有 n 个节点的二叉树，当且仅当其每一个节点都与深度为 k 的满二叉树中，序号为 1 至 n 的节点对应时，称之为 完全二叉树
 
 */

// 二叉树的遍历
/**
 *  (1) 先序遍历: 若二叉树为空，则空操作，否则先访问根节点，再先序遍历左子树，最后先序遍历右子树。
 *  (2) 中序遍历: 若二叉树为空，则空操作，否则先中序遍历左子树，再访问根节点，最后中序遍历右子树。
 *  (3) 后序遍历: 若二叉树为空，则空操作，否则先后序遍历左子树访问根节点，再后序遍历右子树，最后访问根节点。
 */

// 二叉查找树
/**
 *  二叉查找树就是二叉排序树，也叫二叉搜索树。二叉查找树或是一棵空树，或是具有下列性质的二叉树：
 *  (1) 若左子树不空，则左子树上所有结点的值均小于它的根结点的值；
 *  (2) 若右子树不空，则右子树上所有结点的值均大于它的根结点的值；
 *  (3) 左、右子树也分别为二叉排序树；
 *  (4) 没有键值相等的结点。
 */

/// 使用类来实现二叉树
class TreeNode<Element> {
    var val: Element
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Element) {
        self.val = val
    }
}

/// 使用枚举来实现二叉树
enum BinaryTree<T: Comparable> {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)
    
    public var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
    
    public var maxDepth: Int {
        switch self {
        case let .node(left, _, right):
            return max(left.maxDepth + 1, right.maxDepth + 1)
        case .empty:
            return 0
        }
    }
    
    mutating func insert(newValue: T) {
        self = newTreeWithInsertedValue(newValue: newValue)
    }
    
    func search(searchValue: T) -> BinaryTree? {
        switch self {
        case .empty:
            return nil
        case let .node(left, value, right):
            if searchValue == value {
                return self
            }
            if searchValue < value {
                return left.search(searchValue: searchValue)
            } else {
                return right.search(searchValue: searchValue)
            }
        }
    }
    
    private func newTreeWithInsertedValue(newValue: T) -> BinaryTree {
        switch self {
        case .empty:
            return .node(.empty, newValue, .empty)
            
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.newTreeWithInsertedValue(newValue: newValue), value, right)
            } else {
                return .node(left, value, right.newTreeWithInsertedValue(newValue: newValue))
            }
        }
    }
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [" + left.description + "], right = [" + right.description + "]"
        case .empty:
            return ""
        }
    }
}

extension BinaryTree {
    func traverseInOrder(process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }
    
    func traversePreOrder(process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            process(value)
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
        }
    }
    
    func traversePostOrder(process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
            process(value)
        }
    }
}

extension BinaryTree {
    func invert() -> BinaryTree {
        if case let .node(left, value, right) = self {
            return .node(right.invert(), value, left.invert())
        } else {
            return .empty
        }
    }
}

/**
 *  检验这一点的有一个有趣的例子是使用一棵二叉树来进行一系列的计算。我们来进行下面这个例子的运算：(5 * (a - 10)) + (-4 * (3 / b))：
 */
// leaf nodes
let node5 = BinaryTree.node(.empty, "5", .empty)
let nodeA = BinaryTree.node(.empty, "a", .empty)
let node10 = BinaryTree.node(.empty, "10", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)
let node3 = BinaryTree.node(.empty, "3", .empty)
let nodeB = BinaryTree.node(.empty, "b", .empty)

// intermediate nodes on the left
let Aminus10 = BinaryTree.node(nodeA, "-", node10)
let timesLeft = BinaryTree.node(node5, "*", Aminus10)

// intermediate nodes on the right
let minus4 = BinaryTree.node(.empty, "-", node4)
let divide3andB = BinaryTree.node(node3, "/", nodeB)
let timesRight = BinaryTree.node(minus4, "*", divide3andB)

// root node
let tree = BinaryTree.node(timesLeft, "+", timesRight)
tree.count
tree.maxDepth

func testDepth() {
    let node10 = BinaryTree.node(.empty, 10, .empty)
    let node9 = BinaryTree.node(.empty, 9, .empty)
    let node6 = BinaryTree.node(.empty, 9, .empty)
    let node8 = BinaryTree.node(node9, 8, node10)
    let node7 = BinaryTree.node(node6, 7, node8)
    
    node7.maxDepth
}

testDepth()

var binaryTree: BinaryTree<Int> = .empty
binaryTree.insert(newValue: 7)
binaryTree.insert(newValue: 10)
binaryTree.insert(newValue: 2)
binaryTree.insert(newValue: 1)
binaryTree.insert(newValue: 5)
binaryTree.insert(newValue: 9)
binaryTree.traverseInOrder { print("\($0)") }
binaryTree.search(searchValue: 5)
