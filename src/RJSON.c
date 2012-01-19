#include "JSON_parser.h"

#include <Rinternals.h>
#include <Rdefines.h>

#include "ConvertUTF.h"

#include <stdlib.h>


/* A structure which we use to store information that is used within calls
   to the R callback function. The */
typedef struct {
    SEXP func; /* The R expression to call the user-specified function */
    SEXP names; /* the names vector of the type (first argument) which we set on each call.*/
    int encoding; /* The user-specified encoding. XXX fix */
} RJSONParserInfo;

/* Names for the types which we use on R type identifiers in the callback. */
const char *jsonTypeNames[] = {
    "NONE",
    "ARRAY_BEGIN",
    "ARRAY_END",
    "OBJECT_BEGIN",
    "OBJECT_END",
    "INTEGER",
    "FLOAT",
    "NULL",
    "TRUE",
    "FALSE",
    "STRING",
    "KEY"
};

int R_json_basicCallback(void* ctx, int type, const struct JSON_value_struct* value);

SEXP convertJSONValueToR(int type, const struct JSON_value_struct *value, cetype_t encoding);

void R_json_parse_character(SEXP r_input, SEXP maxChar, struct JSON_parser_struct *parser);
void R_json_parse_connection(SEXP r_input, SEXP numLines, struct JSON_parser_struct *parser);

SEXP
R_readFromJSON(SEXP r_input, SEXP depth, SEXP allowComments, SEXP func, SEXP data, SEXP maxChar)
{
    JSON_config conf;
    struct JSON_parser_struct *parser;
    SEXP ans = R_NilValue;

    int do_unprotect = 1;
    
    RJSONParserInfo info = {NULL, NULL, CE_NATIVE};

    init_JSON_config(&conf);
    conf.depth = INTEGER(depth)[0];
    conf.allow_comments = LOGICAL(allowComments)[0];

    /* Handle the callback function and data here. First the C routines and data context.*/
    if(Rf_length(data)) {
        SEXP tmp = VECTOR_ELT(data, 1);
	void *ptr;
	switch(TYPEOF(tmp)) {
	case NILSXP:
	    ptr = NULL;
	    break;
	case INTSXP:
	case LGLSXP:
	    ptr = INTEGER(tmp);
	    break;
	case REALSXP:
	    ptr = REAL(tmp);
	    break;
	case VECSXP:
	    ptr = VECTOR_PTR(tmp);
	    break;
	default:
	    ptr = NULL;
	}
	conf.callback = (JSON_parser_callback) R_ExternalPtrAddr(VECTOR_ELT(data, 0));
	conf.callback_ctx = ptr;
	do_unprotect = 0;
    } else if(func != R_NilValue && TYPEOF(func) == CLOSXP) {
	/* we have a function*/
	SEXP e;
	PROTECT(e = allocVector(LANGSXP, 3));
	SETCAR(e, func);
	SETCAR(CDR(e), allocVector(INTSXP, 1));
	SET_NAMES(CAR(CDR(e)), info.names = NEW_CHARACTER(1));  
	SETCAR(CDR(CDR(e)), R_NilValue);
	info.func = e;
	ans = R_NilValue;
	conf.callback = R_json_basicCallback;
	conf.callback_ctx = &info;
    } else if(func == R_NilValue)
	PROTECT(ans = NEW_LIST(1));
    else { /* You what? */
	PROBLEM "unhandled type of R object as handler function %d", TYPEOF(func)
	    ERROR;
    }


    parser = new_JSON_parser(&conf);

    if(inherits(r_input, "connection")) {
	R_json_parse_connection(r_input, maxChar, parser);
    } else {
	R_json_parse_character(r_input, maxChar, parser);
    }

    if(do_unprotect)
	UNPROTECT(1);
    return(ans);
}

void
R_json_parse_character(SEXP r_input, SEXP maxChar, struct JSON_parser_struct *parser)
{
    const char *input;
    int *ivals = NULL;
    unsigned int count = 0, len;

    int next_char;


    count = INTEGER(maxChar)[0];
    len = INTEGER(maxChar)[1];

    if(TYPEOF(r_input) == RAWSXP)
	input = RAW(r_input);
    else if(TYPEOF(r_input) == INTSXP) {
	ivals = INTEGER(r_input);
    } else
	input = CHAR(STRING_ELT(r_input, 0));

    for (; count < len ; ++count) {

	if(ivals)
	    next_char = ivals[count];
	else
	    next_char = input[count];

        if (next_char <= 0) {
            break;
        }
	// fprintf(stderr, "%d) %c %u\n", count, next_char, (unsigned int) next_char);fflush(stderr);
        if (!JSON_parser_char(parser, next_char)) {
            delete_JSON_parser(parser);
            PROBLEM "JSON parser error: syntax error, byte %d (%c)\n", count, input[count]
	    ERROR;
        }
    }
    if (!JSON_parser_done(parser)) {
        delete_JSON_parser(parser);
	PROBLEM "JSON parser error: syntax error, byte %d\n", count
	ERROR;
    }
}


void
R_json_parse_connection(SEXP r_input, SEXP numLines, struct JSON_parser_struct *parser)
{
    const char *input;
    unsigned int count = 0, len, totalCount = 0, lineCount = 0;
    SEXP call, ans;
    int n, i, maxNumLines;

    PROTECT(call = allocVector(LANGSXP, 3));
    SETCAR(call, Rf_install("readLines"));
    SETCAR(CDR(call), r_input);
    SETCAR(CDR(CDR(call)), ScalarInteger(1));

    maxNumLines = INTEGER(numLines)[0];

    while(1) {

      PROTECT(ans =  Rf_eval(call, R_GlobalEnv));
      n = Rf_length(ans);
      lineCount += n;

      if(n == 0) {
	  UNPROTECT(1);
	  break;
      }

      for(i = 0 ; i < n ; i++) {
	input = CHAR(STRING_ELT(ans, i));
	len = strlen(input);
	for (count = 0; count < len ; ++count, ++totalCount) {
	    int next_char = input[count];
	    if (next_char <= 0) {
		break;
	    }
	    if (!JSON_parser_char(parser, next_char)) {
		delete_JSON_parser(parser);
		PROBLEM "JSON parser error: syntax error, byte %d (%c)", totalCount, input[count]
		    ERROR;
	    }
	}
      }
      UNPROTECT(1);

      if(maxNumLines > 0 && lineCount == maxNumLines)
	  break;
    }

    UNPROTECT(1);
    if (!JSON_parser_done(parser)) {
	delete_JSON_parser(parser);
	PROBLEM "JSON parser error: syntax error, incomplete content" 
	    ERROR;
    }
}







/*
  The "simple"/standard callback to an R function.
 */
int
R_json_basicCallback(void* ctx, int type, const struct JSON_value_struct* value)
{
    RJSONParserInfo *info = ( RJSONParserInfo *) ctx;

    if(info->func != NULL) {
	SEXP result, tmp;
	tmp = CAR(CDR(info->func));

	INTEGER(tmp)[0] = type; /* Names too */

        SET_STRING_ELT(info->names, 0, mkChar(jsonTypeNames[type])); 

	if(value) 
	    SETCAR(CDR(CDR(info->func)), convertJSONValueToR(type, value, info->encoding));
	else if(type == JSON_T_TRUE)
	    SETCAR(CDR(CDR(info->func)), ScalarLogical(1));
	else if(type == JSON_T_FALSE)
	    SETCAR(CDR(CDR(info->func)), ScalarLogical(0));
	else
	    SETCAR(CDR(CDR(info->func)), R_NilValue);

	result = Rf_eval(info->func, R_GlobalEnv);

	if(isLogical(result))
	    return(LOGICAL(result)[0]);
	else if(isInteger(result))
	    return(INTEGER(result)[0]);
	else if(isNumeric(result))
	    return(REAL(result)[0]);
        else
	    return(1);
    }

    return(1);
}


/*
  Convert a JSON object to an R object.
 */ 
SEXP   
convertJSONValueToR(int type, const struct JSON_value_struct *value, cetype_t encoding)
{
    SEXP ans = R_NilValue;
    switch(type) {

      case JSON_T_INTEGER: 
          ans = ScalarInteger((int) ((long) value->vu.integer_value));
	break;
      case JSON_T_FLOAT:
          ans = ScalarReal(value->vu.float_value);
	break;
      case JSON_T_NULL:
          ans = R_NilValue;
	break;
      case JSON_T_FALSE:
          ans = ScalarLogical(0);
	break;
      case JSON_T_TRUE:
          ans = ScalarLogical(1);
	break;
      case JSON_T_STRING:
      case JSON_T_KEY:
	  ans = ScalarString(mkCharLenCE(value->vu.str.value, value->vu.str.length, encoding));
	break;
    }

    return(ans);
}


/*
  An example native/C callback that just prints the type of the elements "passing" through.
 */
int
R_json_testNativeCallback(void* ctx, int type, const struct JSON_value_struct* value)
{
    REprintf("%d (ctx = %p, value = %p)\n", type, ctx, value);
    return(1);
}

int
R_json_degenerateNativeCallback(void* ctx, int type, const struct JSON_value_struct* value)
{
    return(1);
}


/*
  A callback that handles integers (and only integers) 
 */
static int int_cb_counter;
int
R_json_IntegerArrayCallback(void* ctx, int type, const struct JSON_value_struct* value)
{
    int *p = (int *) ctx;
    if(type == JSON_T_ARRAY_BEGIN)
	int_cb_counter = 0;
    else if(type == JSON_T_INTEGER)
      p[int_cb_counter++] = value->vu.integer_value;

    return(1);
}


static int real_cb_counter;
/*
  A callback that handles reals (and only integers) 
 */
int
R_json_RealArrayCallback(void* ctx, int type, const struct JSON_value_struct* value)
{
    double *p = (double *) ctx;
    if(type == JSON_T_ARRAY_BEGIN)
	real_cb_counter = 0;
    else if(type == JSON_T_FLOAT)
        p[real_cb_counter++] = value->vu.float_value;

    return(1);
}


static int logical_cb_counter;
/*
  A callback that handles logicals (and only logicals) 
 */
int
R_json_LogicalArrayCallback(void* ctx, int type, const struct JSON_value_struct* value)
{
    int *p = (int *) ctx;
    if(type == JSON_T_ARRAY_BEGIN)
	logical_cb_counter = 0;
    else if(type == JSON_T_FLOAT)
        p[logical_cb_counter++] = 1;
    else if(type == JSON_T_FLOAT)
        p[logical_cb_counter++] = 1;

    return(1);
}
