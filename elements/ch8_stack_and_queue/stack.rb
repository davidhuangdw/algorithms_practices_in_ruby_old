
class Stack
    attr_accessor :keys
    def initialize
        @keys=[]
    end

    def push(key)
        @keys << key
    end

    def pop
        @keys.pop
    end

    def empty?
        @keys.empty?
    end
end
