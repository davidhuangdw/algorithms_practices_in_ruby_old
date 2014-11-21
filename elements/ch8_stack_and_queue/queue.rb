

class MyQueue
    attr_accessor :keys
    def initialize
        @keys = []
    end

    def push(key)
        @keys.unshift(key)
        self
    end

    def pop
        @keys.pop
    end
end
