//: Playground - noun: a place where people can play

class TreeNode<T: Comparable> {
    var val: T
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: T) {
        self.val = val
    }
    
    func maxDepth(_ root: TreeNode<T>?) -> Int {
        guard let root = root else {
            return 0
        }
        return max(maxDepth(root.left), maxDepth(root.right)) + 1
    }
    
    func isValidBST(_ root: TreeNode<T>?) -> Bool {
        return _helper(node: root, min: nil, max: nil)
    }
    
    
    func traverseInOrder(root: TreeNode<T>?) -> [T] {
        var res = [T]()
        var stack = [TreeNode]()
        var node = root
        
        while !stack.isEmpty || node != nil {
            if node != nil {
                res.append(node!.val)
                stack.append(node!)
                node = node!.left
            } else {
                node = stack.removeLast().right
            }
        }
        
        return res
    }
    
    func levelOrder(root: TreeNode<T>?) -> [[T]] {
        var res = [[T]]()
        
        var queue = [TreeNode]()
        
        if let root = root {
            queue.append(root)
        }
        
        while queue.count > 0 {
            var size = queue.count
            var level = [T]()
            
            for _ in 0..<size {
                let node = queue.removeFirst()
                
                level.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
            }
            
            res.append(level)
        }
        
        return res
    }
    
    private func _helper(node: TreeNode<T>?, min: T?, max: T?) -> Bool {
        guard let node = node else {
            return true
        }
        
        // 所有右子节点都必须大于根节点
        if let min = min, node.val <= min {
            return false
        }
        
        // 所有左子节点都必须小于根节点
        if let max = max, node.val >= max {
            return false
        }
        
        return _helper(node: node.left, min: min, max: node.val) && _helper(node: node.right, min: node.val, max: max)
    }
}




