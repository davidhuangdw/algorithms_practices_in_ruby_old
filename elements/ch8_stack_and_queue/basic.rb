
def sep
    puts '='*70
end

def gen(len=20,max=100)
    len.times.map {rand(max)}
end