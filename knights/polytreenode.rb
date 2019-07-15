class PolyTreeNode
    attr_reader :value, :children, :parent
    
    def initialize(value)
        @value = value
        @children = []
        @parent = nil
    end

    def parent=(parent_node)
        # debugger
        return if parent_node == @parent
        if !@parent.nil?
            @parent.children.delete(self)
        end
        @parent = parent_node
        @parent.children << self unless @parent.nil? || @parent.children.include?(self) 
        self
    end

    def add_child(child_node)
        @children << child_node unless @children.include? child_node
        child_node.parent = self
        return child_node
    end
    
    def remove_child(child_node)
        unless @children.include? child_node
            raise "Error: The node is not a child of this node"
        end
        child_node.parent = nil
    end


    def dfs(target)
        return self if self.value == target
        self.children.each do |child|
            result = child.dfs(target)
            return result unless result.nil?
        end
        return nil
    end

    def bfs(target)
        queue = [self]
        until queue.empty?
            el = queue.shift
            return el if el.value == target
            el.children.each { |child| queue << child }
        end
        return nil
    end
end
