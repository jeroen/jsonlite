readJSONStream =
function(con, cb = NULL,
          simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE)  
{
  if(is(con, "connection"))
#    e = substitute(readLines(con, n = 1), list(con = con))
    e = substitute(readChar(con, 1024), list(con = con))
  else  # Expect an expression or the name of a file
    e = con

  .Call("R_json_parser_init_from_con",  e, cb,
            as.integer(simplify), nullValue, as.logical(simplifyWithNames))
}
