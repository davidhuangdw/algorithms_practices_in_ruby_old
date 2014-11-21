
require_relative 'list'
require_relative '../basic'
a = gen(0)
l = List.new
rec = []
a.reverse.each { |x|  rec << l.insert(x) }
p a
#puts rec
p rec.size
l.each { |nd| nd.jmp = rec[rand(rec.size)] }
new_list = List.copy(l)
puts l
puts new_list

print_id = -> (list) { 
    list.each {|nd| print nd.object_id%1000_000,", "}
    puts
    }

print_jump_id = -> (list) { 
    list.each {|nd| print nd.jmp.object_id%1000_000,", "}
    puts
    }

print_id.call(l)
print_id.call(new_list)
print_jump_id.call(l)
print_jump_id.call(new_list)

