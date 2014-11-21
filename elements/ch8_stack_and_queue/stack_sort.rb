

class Stack
    def initialize; @keys=[] end
    def push(key) @keys<<key end
    def pop; @keys.pop end
    def top; @keys.last end
    def empty?; @keys.empty? end
    def to_s; @keys.to_s end

    include Enumerable
    def each(&block)
        @keys.each(&block)
    end

    def sort!
        return self if @keys.empty?
        e = pop
        sort!
        insert(e)
    end

    def insert(e)
        if empty? || top < e
            push(e)
        else
            r = pop
            insert(e)
            push(r)
        end
        self
    end

end



require_relative 'basic'

a = gen
p a

stack = Stack.new
a.each{|x| stack.push(x)}
puts stack

stack.sort!
puts stack


