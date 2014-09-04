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

  const char* old = CHAR(x);
  char* old_p = (char*)old;

  // Count up the number of matches
  int matches = 0;
  char oldc;
  do {
    oldc = *old_p;
    switch(oldc) {
      case '\\':
      case '"':
      case '\n':
      case '\r':
      case '\t':
      case '\b':
      case '\f':
        matches++;
    }
    old_p++;
  } while(oldc != '\0');

  // Copy old string to new string, replacing where necessary.
  old_p = (char*)old;
  // Allocate string memory; add 2 for start and end quotes.
  char* newstr = (char*)malloc(strlen(old) + matches + 3);
  char* new_p = newstr;
  *new_p = '"';
  new_p++;

  do {
    oldc = *old_p;
    switch(oldc) {
      case '\\':
        *new_p = '\\';
        new_p++;
        *new_p = '\\';
        break;
      case '"':
        *new_p = '\\';
        new_p++;
        *new_p = '"';
        break;
      case '\n':
        *new_p = '\\';
        new_p++;
        *new_p = 'n';
        break;
      case '\r':
        *new_p = '\\';
        new_p++;
        *new_p = 'r';
        break;
      case '\t':
        *new_p = '\\';
        new_p++;
        *new_p = 't';
        break;
      case '\b':
        *new_p = '\\';
        new_p++;
        *new_p = 'b';
        break;
      case '\f':
        *new_p = '\\';
        new_p++;
        *new_p = 'f';
        break;
      case '\0':
        // End with a quote char
        *new_p = '"';
        new_p++;
        *new_p = '\0';
        break;
      default:
        *new_p = oldc;
    }

    old_p++;
    new_p++;
  } while(oldc != '\0');

  SEXP val = mkCharCE(newstr, getCharCE(x));
  free(newstr);
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
