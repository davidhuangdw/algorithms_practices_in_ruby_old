class BinarySearchTree
    def initialize
        @root=nil
    end

    def add(key)
        return @root=Node.new(key) if @root.nil?
        @root.add(key)
    end

    include Enumerable
    def each
        cur = @root
        ancestors=[]
        until cur.nil? && ancestors.empty?
            if cur.nil?
                anc = ancestors.pop
                yield anc
                cur = anc.right
            else
                ancestors << cur
                cur = cur.left
            end
        end
    end

    def print_all
        self.each {|node| print node.key,", "}
        puts
    end

private
    class Node
        attr_accessor :key, :left, :right
        def initialize(key=nil)
            @key=key
            @left = @right = nil
        end

        def add(key)
            if key<=@key
                return @left = Node.new(key) if @left.nil?
                left.add(key)
            else
                return @right = Node.new(key) if @right.nil?
                right.add(key)
            end
        end
    end
end

arr = []
len = 20
max = 100
len.times { arr<<rand(max)}
p arr

tree = BinarySearchTree.new
arr.each {|k| tree.add(k)}
p arr.sort
tree.print_all
