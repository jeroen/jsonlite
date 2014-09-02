#include <Rdefines.h>
#include <Rinternals.h>

SEXP C_collapse_array(SEXP x) {
  if (!isString(x))
    error("x must be a character vector.");

  int len = length(x);
  size_t nchar[len];
  int nchar_total = 0;

  for (int i=0; i<len; i++) {
    nchar[i] = strlen(CHAR(STRING_ELT(x, i)));
    nchar_total += nchar[i];
  }

  char *s = malloc(nchar_total+len+2);
  char *olds = s;

  s[0] = '[';
  s++;
  for (int i=0; i<len; i++) {
    if(i > 0){
      s[0] = ',';
      s++;
    }
    memcpy(s, CHAR(STRING_ELT(x, i)), nchar[i]);
    s += nchar[i];
  }
  s[0] = ']';
  s[1] = '\0';

  SEXP out = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(out, 0, mkChar(olds));
  UNPROTECT(1);
  free(olds);
  return out;
}
