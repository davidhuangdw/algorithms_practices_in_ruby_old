require_relative 'list'
require_relative '../basic'

arr = gen
list = List.new
arr.reverse.each {|x| list.insert(x)}
p list.size

pr = lambda {list.each {|x| print x.key,", "}; puts}
pr.call

list.zip!
pr.call
