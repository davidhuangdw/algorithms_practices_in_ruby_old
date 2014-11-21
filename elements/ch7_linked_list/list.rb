class List
    attr_reader :head
    class Node
        attr_accessor :key, :nxt, :jmp
        def initialize(key=nil,nxt=nil,jmp=nil)
            @key = key
            @nxt = nxt
            @jmp = jmp
        end

        def to_s
            "#{key}(#{jmp})"
        end
    end

    def initialize(head=nil)
        @head = head||Node.new
        self
    end

    def insert(key)
        node = Node.new(key, @head.nxt)
        @head.nxt = node
        node
    end

    include Enumerable
    def each(&block)
        cur = @head.nxt
        until cur.nil?
            yield cur
            cur = cur.nxt
        end
    end

    def to_s
        self.each { |nd| print nd.key,"(), " }
        puts
    end

end

class List
    def split_even
        last = hd = Node.new
        cur = first
        until cur.nil?
            last = last.nxt = cur.nxt
            cur = cur.nxt = last.nxt
        end
        List.new(hd)
    end

    def self.copy(list)
        cur = list.head.nxt
        until cur.nil?
            ins = Node.new(cur.key, cur.nxt)
            cur.nxt = ins
            cur = cur.nxt.nxt
        end

        cur = list.head.nxt
        until cur.nil?
            cur.nxt.jmp = cur.jmp.nxt
            cur = cur.nxt.nxt
        end

        list.split_even
    end
end

class List
    def size
        self.map{1}.inject(:+) || 0
    end

    def insert_node(nd)
        nd.nxt = @head.nxt
        @head.nxt = nd
        self
    end

    def reverse!
        cur = first
        @head.nxt = nil
        until cur.nil?
            nxt = cur.nxt
            insert_node(cur)
            cur = nxt
        end
        self
    end

    def print_key
        each {|x| print x.key,", "}
    end

    def kth(k)
        each_with_index {|x,i| return x if i>=k-1}
    end

    def split_half
        l,r=@head,@head
        l,r = l.nxt, r.nxt.nxt until r.nil? || r.nxt.nil?
        result = List.new(Node.new(nil,l.nxt))
        l.nxt = nil
        result
    end

    def split(k)
        last = kth(k)
        list = List.new(Node.new(nil,last.nxt))
        last.nxt = nil
        list
    end

    def mingle(right)
        last = @head
        a,b = first,right.first
        until a.nil? && b.nil?
            na,nb = a.nxt, b&&b.nxt||nil
            last.nxt = a
            a.nxt = b
            last = b
            a,b=na,nb
        end
        self
    end

    def zip!
        mingle(split_half.reverse!)
    end
end
