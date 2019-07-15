require_relative "polytreenode"
# PolyTreeNode
class KnightPathFinder

    def initialize(starting_pos)
        @root_position = starting_pos
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [@root_node]
        
    end

    def build_move_tree 
        # array 8 * 8
        # with each position we can make 8 moves
        # each move has to be within the grid 
        queue = [@root_node]
        until queue.empty?
            current = queue.shift
            positions = new_move_positions(current.value)
            positions.each do |pos|
                new_node = PolyTreeNode.new(pos)
                current.add_child(new_node)
                queue << new_node
            end
        end
    
    end

    def find_path(end_pos)
        trace_path_back(@root_node.bfs(end_pos))
    end
    
    def trace_path_back(node)
        current_node = node
        path = [node.value]
        until current_node.parent == @root_node
            current_node = current_node.parent
            path.unshift(current_node.value)
        end
        path.unshift(@root_position)
    end



    def self.valid_moves(pos)
        x, y = pos
        positions = [[x+2, y+1], [x+2, y-1],
                     [x-2, y+1], [x-2, y-1],
                     [x+1, y+2], [x-1, y+2],
                     [x+1, y-2], [x-1, y-2]]
        
        positions.select do |position|
            position[0].between?(0, 8) && position[1].between?(0, 8)
        end
    end

    def new_move_positions(pos)
        valid_positions = KnightPathFinder.valid_moves(pos)
        valid_positions = valid_positions.select { |position| !@considered_positions.include?(position) }
        @considered_positions.concat(valid_positions)
        valid_positions
    end
end

