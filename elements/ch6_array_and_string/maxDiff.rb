
class MaxDiff
    INF = 1e9
    def initialize(arr)
        @arr = arr
        @a = [[]]*arr.size
        @b = [[]]*arr.size
    end

    def size
        @arr.size
    end

    def sum(k)
        a(size-1,k)
    end

    def a(i,k)
        return -INF unless i<size && k>=0 && k*2<=i+1
        return 0 if k==0
        return @a[i][k] unless @a[i][k].nil?

        @a[i][k] = [a(i-1,k), @arr[i]+b(i-1,k)].max
    end

    def b(i,k)
        return -INF unless i<size && k>=0 && k*2-1<=i+1
        return 0 if k==0
        return @b[i][k] unless @b[i][k].nil?

        @b[i][k] = [b(i-1,k), -@arr[i]+a(i-1,k-1)].max
    end
end
