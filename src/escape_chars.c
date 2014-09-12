#include <Rdefines.h>
#include <Rinternals.h>
#include <stdlib.h>

/*
Fast escaping of character vectors (Winston Chang)
https://gist.github.com/wch/e3ec5b20eb712f1b22b2
http://stackoverflow.com/questions/25609174/fast-escaping-deparsing-of-character-vectors-in-r/25613834#25613834
*/

SEXP C_escape_chars_one(SEXP x) {

  if (TYPEOF(x) != CHARSXP)
    error("x must be a CHARSXP");

  // Allocate a string with a guaranteed amount of length for escaping
  // Add 2 for initial, ending '"' and 1 for NUL
  const char* p = CHAR(x);
  int n = strlen(p);

  char* out = (char*) malloc(n * 2 + 3);

  int counter = 0;
  out[counter++] = '"';

  for (int i = 0; i < n; ++i) {
    switch(p[i]) {
      case '\\':
        out[counter++] = '\\';
        out[counter++] = '\\';
        break;
      case '"':
        out[counter++] = '\\';
        out[counter++] = '"';
        break;
      case '\n':
        out[counter++] = '\\';
        out[counter++] = 'n';
        break;
      case '\r':
        out[counter++] = '\\';
        out[counter++] = 'r';
        break;
      case '\t':
        out[counter++] = '\\';
        out[counter++] = 't';
        break;
      case '\b':
        out[counter++] = '\\';
        out[counter++] = 'b';
        break;
      case '\f':
        out[counter++] = '\\';
        out[counter++] = 'f';
        break;
      default:
        out[counter++] = p[i];
    }
  }

  out[counter++] = '"';

  // NOTE: this is technically unnecessary given the call to
  // mkCharLenCE following, but it is still 'hygenic' to do so
  out[counter + 1] = '\0';

  SEXP val = mkCharLenCE(out, counter, getCharCE(x));
  free(out);
  return val;
}

SEXP C_escape_chars(SEXP x) {
  if (!isString(x))
    error("x must be a character vector.");
  if (x == R_NilValue || length(x) == 0)
    return x;

  int len = length(x);
  SEXP out = PROTECT(allocVector(STRSXP, len));

  for (int i=0; i<len; i++) {
    SET_STRING_ELT(out, i, C_escape_chars_one(STRING_ELT(x, i)));
  }
  UNPROTECT(1);
  return out;
}
