#include <Rinternals.h>
#include <string.h>

// names is assumed to be sorted, to make names matching faster
// by using a binary search
SEXP C_transpose_list(SEXP x, SEXP names) {
  size_t ncol = Rf_length(names);
  size_t nrow = Rf_length(x);
  SEXP out = PROTECT(allocVector(VECSXP, ncol));

  // Allocate output
  for(size_t i = 0; i < ncol; i++){
    SEXP col = PROTECT(allocVector(VECSXP, nrow));
    SET_VECTOR_ELT(out, i, col);
    UNPROTECT(1);
  }

  // Find and save all elements in their transposed place
  for(size_t j = 0; j < nrow; j++){
    SEXP list = VECTOR_ELT(x, j);
    SEXP listnames = getAttrib(list, R_NamesSymbol);
    size_t listlength = Rf_length(listnames);

    for(size_t k = 0; k < listlength; k++){
      const char * listname = CHAR(STRING_ELT(listnames, k));

      // Binary search for a name match
      size_t low = 0;
      size_t high = ncol - 1;
      size_t mid;
      while(low <= high){
        mid = (low + high) / 2;
        const char * targetname = CHAR(STRING_ELT(names, mid));

        int strcmp_result = strcmp(listname, targetname);
        if(strcmp_result == 0){
          // Match!
          SEXP col = VECTOR_ELT(out, mid);
          SET_VECTOR_ELT(col, j, VECTOR_ELT(list, k));
          break;
        } else if (strcmp_result > 0){
          low = mid + 1;
        } else {
          if (mid == 0) {
            break;
          }
          high = mid - 1;
        }
      }
    }
  }
  //setAttrib(out, R_NamesSymbol, names);
  UNPROTECT(1);
  return out;
}
