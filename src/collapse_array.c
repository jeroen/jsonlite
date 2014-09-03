#include <Rdefines.h>
#include <Rinternals.h>

SEXP C_collapse_array(SEXP x) {
  if (!isString(x))
    error("x must be a character vector.");

  int len = length(x);
  size_t nchar_total = 0;

  for (int i=0; i<len; i++) {
    nchar_total += strlen(CHAR(STRING_ELT(x, i)));
  }

  char *s = malloc(nchar_total+len+3); //if len is 0, we need at least: '[]\0'
  char *olds = s;
  size_t size;

  for (int i=0; i<len; i++) {
    s[0] = ',';
    size = strlen(CHAR(STRING_ELT(x, i)));
    memcpy(++s, CHAR(STRING_ELT(x, i)), size);
    s += size;
  }
  if(len == 0) s++;
  olds[0] = '[';
  s[0] = ']';
  s[1] = '\0';

  SEXP out = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(out, 0, mkChar(olds));
  UNPROTECT(1);
  free(olds);
  return out;
}
