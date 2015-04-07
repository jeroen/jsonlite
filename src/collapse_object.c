#include <Rdefines.h>
#include <Rinternals.h>
#include <stdlib.h>
#include "collapse.h"

SEXP C_collapse_object(SEXP x, SEXP y, SEXP indent) {
  if (!isString(x) || !isString(y))
    error("x and y must character vectors.");

  int len = length(x);
  if (len != length(y))
    error("x and y must same length.");
  if (len == 0) return mkString("{}");

  char *sp, *sp2;
  int ind = asInteger(indent);
  size_t nchar_total = 0;
  int len2;

  for (int i = 0; i < len; i++) {
    nchar_total += strlen(translateCharUTF8(STRING_ELT(x, i)));
    nchar_total += strlen(translateCharUTF8(STRING_ELT(y, i)));
  }
  if (ind == NA_INTEGER) {
    len2 = 2 * len - 1; // ":" and "," (no "," for the last x[i])
  } else {
    // (ind + 2 + 4): ind + 2 for indent spaces; 4 for ": " and ",\n"
    // (no ",\n" for the last x[i])
    len2 = (ind + 6) * len - 2;
    sp = C_spaces(ind);
    sp2 = C_spaces(ind + 2);
    len2 += 2 + ind; // two \n + spaces: "{\nkey: value\n__}"
  }

  char *s = malloc(nchar_total + len2 + 3); // 3 for "{}\0"
  char *olds = s;
  const char *xi;
  size_t size;

  s++;
  for (int i = 0; i < len; i++) {
    xi = translateCharUTF8(STRING_ELT(x, i));
    size = strlen(xi);

    // add x
    if (ind == NA_INTEGER) {
      memcpy(s, xi, size);
      s += size;
    } else {
      if (i == 0) {
        s[0] = '\n';
        s++;
      }
      memcpy(s, sp2, ind + 2);
      s += ind + 2;
      memcpy(s, xi, size);
      s += size;
    }

    //add :
    s[0] = ':';
    s++;
    if (ind != NA_INTEGER) {
      s[0] = ' ';
      s++;
    }

    xi = translateCharUTF8(STRING_ELT(y, i));
    size = strlen(xi);
    //add y
    memcpy(s, xi, size);
    s += size;

    if (i < len - 1) {
      s[0] = ',';
      s++;
    }
    if (ind != NA_INTEGER) {
      s[0] = '\n';
      s++;
      if (i == len - 1) {
        memcpy(s, sp, ind);
        s += ind;
      }
    }
  }
  olds[0] = '{';
  s[0] = '}';
  s[1] = '\0';

  //get character encoding from first element
  SEXP out = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(out, 0, mkCharCE(olds,  CE_UTF8));
  UNPROTECT(1);
  free(olds);
  return out;
}
