str = "[ 1, {}, [1, 3, 5] ]" 
fromJSON(str)

fromJSON('[ "abc", "def"]')

fromJSON('[ 1, 2, null]',  nullValue = 123)

fromJSON('[ true, false]')
fromJSON('[ true, false, 1]')

fromJSON('[ 1, 2, true]')
fromJSON('[ 1, 2, 3.4, false]')

fromJSON('[ 1, 2, 3.4, 1, null]')



fromJSON('{ "a" : 1, "b" : "duncan", "f": [ 1, 2]}')

toJSON(list(1, 2, list(NA)), .na = -9999)



x = '[ 1, 2, {"a": [ 10, [3, 4] ], "bcd": {"xy":  [1, 2], "wy": {"hij": true, "wsd": [true, false]}}}]'
fromJSON(x)


toJSON(list(a = pi, b = matrix(c(1:3, pi), 2, 2)), digits = 10)

