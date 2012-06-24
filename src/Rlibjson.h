#include <libjson/libjson.h>
#include <Rdefines.h>
#include <Rinternals.h>

typedef enum { NATIVE_STR_ROUTINE,  SEXP_STR_ROUTINE, R_FUNCTION, GARBAGE} StringFunctionType;

typedef SEXP (*SEXPStringRoutine)(const char *, cetype_t encoding);
typedef char * (*StringRoutine)(const char *);

SEXP processJSONNode(JSONNODE *node, int parentType, int simplify, SEXP nullValue,
                      int simplifyWithNames, cetype_t, SEXP strFun,  StringFunctionType str_fun_type);


typedef enum {NONE, ALL, STRICT_LOGICAL = 2, STRICT_NUMERIC = 4, STRICT_CHARACTER = 8, STRICT = 14} SimplifyStyle;

