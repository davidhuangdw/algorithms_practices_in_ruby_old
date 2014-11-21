require_relative 'stack'

class QueueFromStack
    def initialize
        @l,@r=Stack.new, Stack.new
    end

    def push(key)
        @l.push(key)
    end

    def pop
        return @r.pop unless @r.empty?
        @r.push(@l.pop) until @l.empty?
        @r.pop
    end

    def keys
        @l.keys.reverse+@r.keys
    end
end
