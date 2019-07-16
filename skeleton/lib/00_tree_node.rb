class PolyTreeNode
    def initialize(value)
      @value = value
      @parent = nil
      @children = []
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def value
        @value
    end

    def parent=(new_parent) # what we want -> b.value = a
      
        if @parent
            @parent.children.delete(self)
        end

        @parent = new_parent

        if @parent.nil?
            return nil
        else
            new_parent.children << self if !new_parent.children.include?(self)
        end
    end

    def add_child(child_node)
      child_node.parent = self
    end

    def remove_child(child_node)
      if !child_node.parent
        raise "node is not a child"
      end

      child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
    
        if !self.children.empty?
            self.children.each do |child| 
                result = child.dfs(target_value)
                return result unless result.nil?
            end
        end
      return nil  
    end

    def bfs(target = nil, &prc)
        raise "Need a proc or target" if [target, prc].none?
        prc ||= Proc.new { |node| node.value == target }

        nodes = [self]
        until nodes.empty?
            node = nodes.shift

            return node if prc.call(node)
            nodes.concat(node.children)
        end

        nil
    end
      
    #     queue = [self] #[b c]

    #     while queue.length > 0
    #         queue.each do |node| # c
    #             return node if node.value == target_value
    #             queue.concat(node.children) unless node.children.nil?
    #             queue.delete(node) # [d e f g]
    #         end
    #     end
    #     return nil
    # end
    
end

# b.parent = a
# @parent = a
# a.children << self

#    j             target value = g
#   b c             d = nil
# d e f g           e = nil
                    # f = nil
                    # g = correct
# Stack Frame 1          <-    
# node: d, value: 'd'     |     
# Children []             |     
#                         |
#                         |
# Stack Frame 2           |   <-
# node: b, value:'b'      |    |
# Children ['d', 'e']     |    |
#            ^ d.dfs('d')--    |
#                              |
# Stack Frame 1 (root)         |
# node: a, value: 'a'          |
# Children ['b', 'c']          |
#            ^ b.dfs('d') -----


# class node
#   attr_reader :value, :children

#   def initialize(value, children = [])
#     @value = value
#     @children = children
#   end

#   def bfs(target)
#     # 1 - Create a queue, with root node inside
#     node_queue = MyQueue.new()
#     node_queue.enqueue(self) # self is the root node

#     until node_queue.empty?
#       # 2a - dequeue node
#       curr_node = node_queue.dequeue
#       # 2b - check node value against target
#       return curr_node if curr_node.value == target
#       # 2c - add children to queue
#       curr_node.children.each do |child|
#         node_queue.enqueue(child)
#       end
#     end
#     # 3 - return nil, as we broke out of the loop and did not find the node and
#     #return early
#     nil
#   end
# end

# d = Node.new('d')
# e = Node.new('e')
# f = Node.new('f')
# g = Node.new('g')
# b = Node.new('b', [d, e])
# c = Node.new('b', [f, g])
# a = Node.new('b', [b, c])