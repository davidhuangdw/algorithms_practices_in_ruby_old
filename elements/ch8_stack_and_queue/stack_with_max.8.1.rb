
class Stack
    def initialize
        @keys=[]
        @history = []
    end

    def push(key)
        @keys << key
        @history << key if @history.empty? || @history[-1] <= key
        self
    end

    def pop
        raise Exception, "Empty stack" if @keys.empty?
        key = @keys.pop
        @history.pop if key == @history[-1]
        key
    end

    def max
        raise Exception, "Empty stack" if @history.empty?
        @history[-1]
    end
end


len = 20
max = 100
arr = []
s = Stack.new
len.times {
    arr << rand(max)
    s.push(arr[-1])
    puts "max=#{s.max}, #{arr.max}"
}

(len-1).times {
    puts s.pop==arr.pop
    puts "max=#{s.max}, #{arr.max}"
}