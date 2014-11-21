Enum = require './enum'

puts = console.log

method = (name) ->
  (obj) -> obj[name]()

zip = (a,b) ->
  [a[i],b[i]] for i in [0...a.length]

cmp = (a, b) ->
  for [x,y] in zip(a,b)
    return x-y unless x==y
  0

segment = (left, right, height)->
  left: left
  right: right
  height: height
  to_ary: -> [@left,@right,@height]
  cmp: (other)-> cmp @to_ary(),other.to_ary()

divide = (arr) ->
  hf = Math.ceil arr.length/2
  [arr[0...hf], arr[hf..-1]]

adjoint = (segments) ->
  result = []
  for x in segments[0..-1]
    last = result[result.length-1]
    if last? && last.height == x.height && last.right == x.left
      last.right = x.right
    else result.push(x)
  result

merge = (->
  l = r = undefined
  x = y = undefined

  peek = -> [x,y] = [l.peek(),r.peek()]

  is_separate = -> x.right <= y.left

  is_overlap_begin = -> x.left == y.left

  extract_overlap = ->
    x.height = Math.max x.height,y.height
    if x.right == y.right then r.next() else y.left=x.right
    l.next()

  extract_unoverlap = ->
    result = segment(x.left, y.left, x.height)
    x.left = y.left
    result

  extract_smaller = ->
    peek()
    if x.cmp(y) > 0
      [l,r] = [r,l]
      peek()
    return l.next() if is_separate()
    if is_overlap_begin()
      extract_overlap()
    else extract_unoverlap()

  (left, right)->
    [l,r]=[Enum.Enum(left), Enum.Enum(right)]
    result = []
    Enum.loop ->
      result.push extract_smaller()
    Enum.loop ->
      result.push l.next()
    Enum.loop ->
      result.push r.next()
    result
)()

draw_by_merge = (->
  safe_draw = (buildings) ->
    return buildings if buildings.length <= 1
    [l,r] = divide buildings
    merge safe_draw(l),safe_draw(r)

  (buildings) ->
    buildings = buildings.map((a)->segment(a...)).sort((a,b)->a.cmp(b))
    (adjoint safe_draw(buildings)).map (s)->s.to_ary()
)()


module.exports=
  segment: segment,
  draw_by_merge: draw_by_merge
