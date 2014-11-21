require_relative 'queue'

class QueueWithMax < MyQueue
    def initialize
        super
        @maxes=[]
    end

    def push(key)
        super key
        @maxes.shift until @maxes.empty? \
                        || @maxes.last >= key
        @maxes.unshift(key)
    end

    def pop
        key = super
        @maxes.pop if (not @maxes.empty?) \
                        && @maxes.last == key
        key
    end

    def max
        @maxes.last
    end
end
