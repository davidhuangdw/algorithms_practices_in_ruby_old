puts = console.log

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
  l = r = x = y = undefined
  il = ir = 0

  is_separate = -> x.right <= y.left
  is_overlap_begin = -> x.left == y.left

  extract_overlap = ->
    x.height = Math.max x.height,y.height
    if x.right == y.right then ir++ else y.left=x.right
    il++
    x

  extract_unoverlap = ->
    result = segment(x.left, y.left, x.height)
    x.left = y.left
    result

  swap = ->
    [x,y,l,r,il,ir] = [y,x,r,l,ir,il]

  extract_smaller = ->
    [x,y] = [l[il],r[ir]]
    swap() if x.cmp(y)>0
    return l[il++] if is_separate()
    if is_overlap_begin()
      extract_overlap()
    else extract_unoverlap()

  (left, right)->
    [l,r]=[left,right]
    il=ir=0
    result = []
    while il<l.length and ir<r.length
      result.push extract_smaller()
    result.concat(l[il..-1]).concat(r[ir..-1])
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
