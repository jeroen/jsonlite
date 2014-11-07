#include <Rdefines.h>
#include <Rinternals.h>
#include <stdlib.h>
#include <modp_numtoa.h>

SEXP R_num_to_char(SEXP x, SEXP digits, SEXP na_as_string, SEXP use_signif) {
  int len = length(x);
  int na_string = asLogical(na_as_string);
  int signif = asLogical(use_signif);
  char buf[32];
  SEXP out = PROTECT(allocVector(STRSXP, len));
  if(isInteger(x)){
    for (int i=0; i<len; i++) {
      if(INTEGER(x)[i] == NA_INTEGER){
        if(na_string == NA_LOGICAL){
          SET_STRING_ELT(out, i, NA_STRING);
        } else if(na_string){
          SET_STRING_ELT(out, i, mkChar("\"NA\""));
        } else {
          SET_STRING_ELT(out, i, mkChar("null"));
        }
      } else {
        modp_itoa10(INTEGER(x)[i], buf);
        SET_STRING_ELT(out, i, mkChar(buf));
      }
    }
  } else if(isReal(x)) {
    int precision = asInteger(digits);
    double * xreal = REAL(x);
    for (int i=0; i<len; i++) {
      double val = xreal[i];
      if(!R_FINITE(val)){
        if(na_string == NA_LOGICAL){
          SET_STRING_ELT(out, i, NA_STRING);
        } else if(na_string){
          if(ISNA(val)){
            SET_STRING_ELT(out, i, mkChar("\"NA\""));
          } else if(ISNAN(val)){
            SET_STRING_ELT(out, i, mkChar("\"NaN\""));
          } else if(val == R_PosInf){
            SET_STRING_ELT(out, i, mkChar("\"Inf\""));
          } else if(val == R_NegInf){
            SET_STRING_ELT(out, i, mkChar("\"-Inf\""));
          } else {
            error("Unrecognized non finite value.");
          }
        } else {
          SET_STRING_ELT(out, i, mkChar("null"));
        }
      } else if(precision == NA_INTEGER){
        snprintf(buf, 32, "%.15g", val);
        SET_STRING_ELT(out, i, mkChar(buf));
      } else if(signif){
        //use signifant digits rather than decimal digits
        snprintf(buf, 32, "%.*g", (int) ceil(fmin(15, precision)), val);
        SET_STRING_ELT(out, i, mkChar(buf));
      } else if(precision > -1 && precision < 10 && fabs(val) < 2147483647 && fabs(val) > 1e-5) {
        //preferred method: fast with fixed decimal digits
        //does not support large numbers or scientific notation
        modp_dtoa2(val, buf, precision);
        SET_STRING_ELT(out, i, mkChar(buf));
        //Rprintf("Using modp_dtoa2\n");
      } else {
        //fall back on sprintf (includes scientific notation)
        //limit total precision to 15 significant digits to avoid noise
        //funky formula is mostly to convert decimal digits into significant digits
        snprintf(buf, 32, "%.*g", (int) ceil(fmin(15, fmax(1, log10(val)) + precision)), val);
        SET_STRING_ELT(out, i, mkChar(buf));
        //Rprintf("Using sprintf with precision %d digits\n",(int) ceil(fmin(15, fmax(1, log10(val)) + precision)));
      }
    }
  } else {
    error("num_to_char called with invalid object type.");
  }

  UNPROTECT(1);
  return out;
}
