#include <Rdefines.h>
#include <Rinternals.h>
#include <stdlib.h>
#include <stdbool.h>

/*
This function takes a list and replaces all NULL values by NA.
In addition, it will replace strings matched by 'naStrings'
(defaults to "NA" "NaN" "Inf" and "-Inf") with NA, unless there is
at least one non-na string element in the list.
In that case converting to real values has no point because
unlist() will coerse them back into a string anyway.
*/

SEXP C_null_to_na(SEXP x, SEXP naStrings) {
  int len = length(x);
  if(len == 0) return x;

  int len_naStrings = length(naStrings);
  bool looks_like_na_string = false;
  bool looks_like_character_vector = false;

  for (int i=0; i<len; i++) {
    if(VECTOR_ELT(x, i) == R_NilValue) {
      //null always turns into NA
      SET_VECTOR_ELT(x, i, ScalarLogical(NA_LOGICAL));
    } else if(!looks_like_character_vector && TYPEOF(VECTOR_ELT(x, i)) == STRSXP){
      looks_like_na_string = false;
      for (int j=0; j < len_naStrings; j++) {
        if(!looks_like_na_string &&
           strcmp(CHAR(STRING_ELT(naStrings, j)),
                  CHAR(STRING_ELT(VECTOR_ELT(x, i), 0))) == 0) {
          looks_like_na_string = true;
        }
      }
      if(!looks_like_na_string) {
        looks_like_character_vector = true;
      }
    }
  }

  // if this is a character vector, do not parse NA strings.
  if(looks_like_character_vector) return(x);

  //parse NA strings
  for (int i=0; i<len; i++) {
    if(TYPEOF(VECTOR_ELT(x, i)) == STRSXP){
      if(strcmp("NA", CHAR(STRING_ELT(VECTOR_ELT(x, i), 0))) == 0) {
        SET_VECTOR_ELT(x, i, ScalarLogical(NA_LOGICAL));
        continue;
      }
      if(strcmp("NaN", CHAR(STRING_ELT(VECTOR_ELT(x, i), 0))) == 0) {
        SET_VECTOR_ELT(x, i, ScalarReal(R_NaN));
        continue;
      }
      if(strcmp("Inf", CHAR(STRING_ELT(VECTOR_ELT(x, i), 0))) == 0) {
        SET_VECTOR_ELT(x, i, ScalarReal(R_PosInf));
        continue;
      }
      if(strcmp("-Inf", CHAR(STRING_ELT(VECTOR_ELT(x, i), 0))) == 0) {
        SET_VECTOR_ELT(x, i, ScalarReal(R_NegInf));
        continue;
      }
      for (int j=0; j < len_naStrings; j++) {
        if(strcmp(CHAR(STRING_ELT(naStrings, j)),
                  CHAR(STRING_ELT(VECTOR_ELT(x, i), 0))) == 0)  {
          SET_VECTOR_ELT(x, i, ScalarLogical(NA_LOGICAL));
          break;
        }
      }
    }
  }

  //return updated list
  return x;
}
