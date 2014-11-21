def cut_zero!(arr)
    arr.pop until arr.empty? || arr.last!=0
    arr<<0 if arr.empty?
    arr
end

def to_digits(s)
    res = []
    s.reverse.each_char {|c| res<<c.to_i}
    cut_zero!(res)
    res
end

class MyInteger
    def initialize(s="")
        raise "#{s} is not a legal number" unless number?(s)
        @digits = to_digits(s)
    end

    def number?(s)
        s =~ /\d*/
    end

    def to_s
        s = ""
        @digits.each {|d| s<<d.to_s}
        s.reverse
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

    def add_array(a,b)
        c = []
        carry = 0
        a.zip(b) do |x,y|
            carry += (x||0) + (y||0)
            c << carry%10
            carry /= 10
        end
        append_array!(c,carry)
        cut_zero!(c)
        c
    end

    def mul_array(a,b)
        c = []
        b.each_with_index do |y,j|
            carry = 0
            a.each_with_index do |x,i|
                carry += (c[i+j]||0) + x*y
                c[i+j] = carry%10
                carry /= 10
            end
            append_array!(c, carry, a.size+j)
        end
        cut_zero!(c)
        c
    end

    def append_array!(a, carry, pos=nil)
        pos = pos||a.size
        until carry.zero? do
            carry += (a[pos]||0)
            a[pos] = carry%10
            carry /= 10
            pos += 1
        end
    end

protected 
    attr_accessor :digits
end
