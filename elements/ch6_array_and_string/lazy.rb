
class LazyArray
    def initialize
        @keys = []
        @order = []
        @pos_in_order = (0..1000).to_a
    end

    def size
        @order.size
    end

    def vis(i)
        pos = @pos_in_order[i]
        return false if pos>=size || @order[pos]!=i
        true
    end

    def [](i)
        return false unless vis(i)
        @keys[i]
    end

    def []=(i,v)
        @keys[i] = v
        unless vis(i)
            @order.push(i)
            @pos_in_order[i] = size-1
        end
    end
end
