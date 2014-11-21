// Generated by CoffeeScript 1.7.1
(function() {
  var adjoint, cmp, divide, draw_by_merge, merge, puts, segment, zip;

  puts = console.log;

  zip = function(a, b) {
    var i, _i, _ref, _results;
    _results = [];
    for (i = _i = 0, _ref = a.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      _results.push([a[i], b[i]]);
    }
    return _results;
  };

  cmp = function(a, b) {
    var x, y, _i, _len, _ref, _ref1;
    _ref = zip(a, b);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      _ref1 = _ref[_i], x = _ref1[0], y = _ref1[1];
      if (x !== y) {
        return x - y;
      }
    }
    return 0;
  };

  segment = function(left, right, height) {
    return {
      left: left,
      right: right,
      height: height,
      to_ary: function() {
        return [this.left, this.right, this.height];
      },
      cmp: function(other) {
        return cmp(this.to_ary(), other.to_ary());
      }
    };
  };

  divide = function(arr) {
    var hf;
    hf = Math.ceil(arr.length / 2);
    return [arr.slice(0, hf), arr.slice(hf)];
  };

  adjoint = function(segments) {
    var last, result, x, _i, _len, _ref;
    result = [];
    _ref = segments.slice(0);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      x = _ref[_i];
      last = result[result.length - 1];
      if ((last != null) && last.height === x.height && last.right === x.left) {
        last.right = x.right;
      } else {
        result.push(x);
      }
    }
    return result;
  };

  merge = (function() {
    var extract_overlap, extract_smaller, extract_unoverlap, il, ir, is_overlap_begin, is_separate, l, r, swap, x, y;
    l = r = x = y = void 0;
    il = ir = 0;
    is_separate = function() {
      return x.right <= y.left;
    };
    is_overlap_begin = function() {
      return x.left === y.left;
    };
    extract_overlap = function() {
      x.height = Math.max(x.height, y.height);
      if (x.right === y.right) {
        ir++;
      } else {
        y.left = x.right;
      }
      il++;
      return x;
    };
    extract_unoverlap = function() {
      var result;
      result = segment(x.left, y.left, x.height);
      x.left = y.left;
      return result;
    };
    swap = function() {
      var _ref;
      return _ref = [y, x, r, l, ir, il], x = _ref[0], y = _ref[1], l = _ref[2], r = _ref[3], il = _ref[4], ir = _ref[5], _ref;
    };
    extract_smaller = function() {
      var _ref;
      _ref = [l[il], r[ir]], x = _ref[0], y = _ref[1];
      if (x.cmp(y) > 0) {
        swap();
      }
      if (is_separate()) {
        return l[il++];
      }
      if (is_overlap_begin()) {
        return extract_overlap();
      } else {
        return extract_unoverlap();
      }
    };
    return function(left, right) {
      var result, _ref;
      _ref = [left, right], l = _ref[0], r = _ref[1];
      il = ir = 0;
      result = [];
      while (il < l.length && ir < r.length) {
        result.push(extract_smaller());
      }
      return result.concat(l.slice(il)).concat(r.slice(ir));
    };
  })();

  draw_by_merge = (function() {
    var safe_draw;
    safe_draw = function(buildings) {
      var l, r, _ref;
      if (buildings.length <= 1) {
        return buildings;
      }
      _ref = divide(buildings), l = _ref[0], r = _ref[1];
      return merge(safe_draw(l), safe_draw(r));
    };
    return function(buildings) {
      buildings = buildings.map(function(a) {
        return segment.apply(null, a);
      }).sort(function(a, b) {
        return a.cmp(b);
      });
      return (adjoint(safe_draw(buildings))).map(function(s) {
        return s.to_ary();
      });
    };
  })();

  module.exports = {
    segment: segment,
    draw_by_merge: draw_by_merge
  };

}).call(this);

//# sourceMappingURL=drawing_skyline.map
