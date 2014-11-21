
def cut_zero!(res)
    res.pop until res.empty? || res.last != 0
    res << 0 if res.empty?
end

def to_digits(str)
    res = []
    str.reverse.each_char {|c| res<<c.to_i}
    cut_zero!(res)
    res
end

class MyInteger
    def initialize(str="")
        raise "illegal string" unless str =~ /^\d*$/
        @digits = to_digits(str)
    end

    def to_s
        res = ""
        @digits.each {|x| res<<x.to_s}
        res.reverse
    end

    def +(b)
        res = MyInteger.new
        res.digits = add_array(@digits, b.digits)
        res
    end

    def *(b)
        res = MyInteger.new
        res.digits = mul_array(@digits, b.digits)
        res
    end

    def mul_array(a,b)
        c = []
        b.each_with_index do |y,j|
            carry = 0
            a.each_with_index do |x,i|
                carry += (c[i+j]||0)+x*y
                c[i+j] = carry%10
                carry /= 10
            end
            append_array!(c, carry, a.size+j)
        end
        cut_zero!(c)
        c
    end

    def add_array(a, b)
        c = []
        carry = 0
        a.zip(b).each do|x,y|
            x,y = x||0, y||0
            carry += x+y
            c << carry%10
            carry /= 10
        end
        append_array!(c, carry)
        cut_zero!(c)
        c
    end

    def append_array!(arr, carry, pos=nil)
        pos = pos||arr.size
        until carry.zero? do
            arr[pos] = (arr[pos]||0)+carry%10
            carry /= 10
            pos += 1
        end
    end

protected
    attr_accessor :digits
end
