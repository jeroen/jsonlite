n = seq(1000, 100000, by = 5000)
new.times = sapply(n, function(n) system.time(invisible(toJSON(rpois(n, 4)))))

library(rjson)
new.times = sapply(n, function(n) system.time(invisible(toJSON(rpois(n, 4)))))

###################

json = sapply(n, function(n) toJSON(rpois(n, 2)))
fromJSON.new.times = sapply(json, function(v) system.time(fromJSON(v, asText = TRUE)))

fromJSON.new.times.10000 = sapply(json, function(v) system.time(fromJSON(v, default.size = 10000, asText = TRUE)))


library(rjson)
fromJSON.old.times = sapply(json, function(v) system.time(fromJSON(v)))

colnames(fromJSON.old.times) = colnames(fromJSON.new.times) = n
save(fromJSON.new.times, fromJSON.new.times.10000, fromJSON.old.times, n, file = "inst/doc/fromJSONTimes.rda")


###############################

n = seq(1000, by = 1000, 10000)
v = sapply(n, function(n) toJSON(rpois(n, 4)))

a = sapply(v, function(x) system.time(fromJSON(x)), USE.NAMES = FALSE)

b = sapply(v, function(x) system.time(fromJSON(x, RJSONIO:::simpleJSONHandler())), USE.NAMES = FALSE)

f = get("fromJSON", "package:rjson")

c = sapply(v, function(x) system.time(f(x)), USE.NAMES = FALSE)

d = sapply(v, function(x) {
                system.time({
                     buf = rep(as.integer(NA), 100000)
                     fromJSON(v,getNativeSymbolInfo("R_json_IntegerArrayCallback", PACKAGE = "RJSONIO"),
                              data = buf)
                     buf[!is.na(buf)]
                   })
              }, USE.NAMES = FALSE)

matplot(n, cbind(a[3,], b[3,], c[3,], d[3,]), type = "l")

D = data.frame(n = rep(n, 4),
               elapsed = c(a[3,], b[3,], c[3,], d[3,]),
               type = rep(c("default", "simple", "rjson", "C"), each = ncol(a)))
           
xyplot(elapsed ~ n, D, group = type, type = "l", auto.key = list(columns = length(levels(D$type))))

