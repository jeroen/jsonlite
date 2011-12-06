library(RJSONIO)
i = fromJSON("[123]")[[1]]
is.integer(i)
i == 123L


x = fromJSON("[12345678901]")[[1]]
is.numeric(x[[1]])
x == 12345678901

x = fromJSON("[-12345678901]")[[1]]
is.numeric(x[[1]])
x == -12345678901


