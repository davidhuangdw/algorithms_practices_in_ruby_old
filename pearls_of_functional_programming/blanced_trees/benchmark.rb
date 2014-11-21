require_relative 'splay'
require_relative 'treap'
require 'benchmark'

size = ARGV[0] || 100
size = size.to_i
values = (0...size).to_a * 2
values = values.reverse
if ARGV.include? "shuffle"
  values = values.shuffle
end

public def run(values)
  values.each {|v| self.insert(v)}
  values.last(size/4).each {|v| self.remove(v)}
end

bt = BinaryTree.new
immu_bt = ImmutableBinaryTree.new
treap = TreapTree.new
immu_treap = ImmutableTreapTree.new
splay = SplayTree.new
immu_splay = ImmutableSplayTree.new
Benchmark.bmbm do |x|
  x.report("BinaryTree") {bt.run(values)}
  x.report("Immutable BinaryTree") {immu_bt.run(values)}
  x.report("Treap") {treap.run(values)}
  x.report("Immutable Treap") {immu_treap.run(values)}
  x.report("Splay") {splay.run(values)}
  x.report("Immutable Splay") {immu_splay.run(values)}
end
