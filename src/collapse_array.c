#include <Rdefines.h>
#include <Rinternals.h>
#include <stdlib.h>

SEXP C_collapse_array(SEXP x) {
  if (!isString(x))
    error("x must be a character vector.");

  int len = length(x);
  size_t nchar_total = 0;

  for (int i=0; i<len; i++) {
    nchar_total += strlen(translateCharUTF8(STRING_ELT(x, i)));
  }

  char *s = malloc(nchar_total+len+3); //if len is 0, we need at least: '[]\0'
  char *olds = s;
  size_t size;

  for (int i=0; i<len; i++) {
    s[0] = ',';
    size = strlen(translateCharUTF8(STRING_ELT(x, i)));
    memcpy(++s, translateCharUTF8(STRING_ELT(x, i)), size);
    s += size;
  }
  if(olds == s) s++;
  olds[0] = '[';
  s[0] = ']';
  s[1] = '\0';

  //get character encoding from first element
  SEXP out = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(out, 0, mkCharCE(olds,  CE_UTF8));
  UNPROTECT(1);
  free(olds);
  return out;
}

char *C_spaces(int n) {
  char *s = malloc(n + 1);
  memset(s, ' ', n);
  s[n] = '\0';
  return s;
}

SEXP C_collapse_array_indent(SEXP x, SEXP inner, SEXP indent) {
  int ind = asInteger(indent);
  if (ind == NA_INTEGER) return(C_collapse_array(x));

  if (!isString(x))
    error("x must be a character vector.");

  int len = length(x);
  if (len == 0) return mkString("[]");

  int len2; // extra length needed for "[]" and separators such as ", "
  char *sp, *sp2; // spaces for indentation

  if (asLogical(inner)) {
    // inner array: a comma and a space after each x[i] except the last x[i]
    len2 = 2 * (len - 1);
  } else {
    // outer array: "[\n____x[i],\n__]"
    // (ind + 2) * len + 2 * (len - 1) + ind + 1 + 1
    // (ind + 2) spaces before each x[i], 2 chars ",\n" after each x[i] except
    // the last x[i], 1 "\n" and ind spaces before the outer ], 1 "\n" after the
    // outer [
    len2 = (ind + 4) * len + ind;
    sp = C_spaces(ind);
    sp2 = C_spaces(ind + 2);
  }
  size_t nchar_total = 0;

  for (int i = 0; i < len; i++) {
    nchar_total += strlen(translateCharUTF8(STRING_ELT(x, i)));
  }

  char *s = malloc(nchar_total + len2 + 3); // 3 for the outside "[]\0"
  char *olds = s;
  const char *xi;
  size_t size;

  for (int i = 0; i < len; i++) {
    xi = translateCharUTF8(STRING_ELT(x, i));
    size = strlen(xi);
    if (asLogical(inner)) {
      memcpy(++s, xi, size);
      s += size;
      if (i < len - 1) {
        s[0] = ',';
        s[1] = ' ';
        s++;
      }
    } else {
      if (i == 0) {
        s[1] = '\n';
        s += 2;
      }
      memcpy(s, sp2, ind + 2);
      s += ind + 2;
      memcpy(s, xi, size);
      s += size;
      if (i < len - 1) {
        s[0] = ',';
        s[1] = '\n';
        s += 2;
      } else {
        s[0] = '\n';
        s++;
        memcpy(s, sp, ind);
        s += ind;
      }
    }
  }
  olds[0] = '[';
  s[0] = ']';
  s[1] = '\0';

  SEXP out = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(out, 0, mkCharCE(olds,  CE_UTF8));
  UNPROTECT(1);
  free(olds);
  return out;
}
