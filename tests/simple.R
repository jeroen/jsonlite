library(RJSONIO)
x = "[1, 3, 10, 19]"
fromJSON(I(x))

h = RJSONIO:::basicJSONHandler()
fromJSON(x, h$update)

if(!(fromJSON(I("[3.1415]")) == 3.1415))
  stop("Failed for doubles")


# From couchdb

x = '{"total_rows":3,"offset":0,"rows":[{"id":"abc","key":"xyz","value":{"rev":"1-3980939464"}},{"id":"x123","key":"x123","value":{"rev":"1-1794908527"}}]}\n'

fromJSON(x)









