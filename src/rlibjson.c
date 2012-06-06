#include <libjson/libjson.h>
#include <Rdefines.h>
#include <Rinternals.h>


typedef enum { NATIVE_STR_ROUTINE,  SEXP_STR_ROUTINE, R_FUNCTION, GARBAGE} StringFunctionType;

typedef SEXP (*SEXPStringRoutine)(const char *, cetype_t encoding);
typedef char * (*StringRoutine)(const char *);

SEXP processJSONNode(JSONNODE *node, int parentType, int simplify, SEXP nullValue,
                      int simplifyWithNames, cetype_t, SEXP strFun,  StringFunctionType str_fun_type);


typedef enum {NONE, ALL, STRICT_LOGICAL = 2, STRICT_NUMERIC = 4, STRICT_CHARACTER = 8, STRICT = 14} SimplifyStyle;

int setType(int cur, int newType);
SEXP makeVector(SEXP l, int len, int type, SEXP nullValue);

/* Simple routine to return the parsed JSONNODE pointer.
   This would be the start of allowing the caller to manipulate the tree
   directly. */
SEXP
R_json_parse(SEXP str)
{
    JSONNODE *node;
    node = json_parse(CHAR(STRING_ELT(str, 0)));
    return(R_MakeExternalPtr(node, Rf_install("JSONNODE"), R_NilValue));
}

SEXP
R_fromJSON(SEXP r_str, SEXP simplify, SEXP nullValue, SEXP simplifyWithNames, SEXP encoding,
            SEXP r_stringFun, SEXP r_str_type)
{
    const char * str = CHAR(STRING_ELT(r_str, 0));
    JSONNODE *node;
    SEXP ans;
    int nprotect = 0;
    StringFunctionType str_fun_type = GARBAGE;

    if(r_stringFun != R_NilValue) {
	if(TYPEOF(r_stringFun) == CLOSXP) {
	    SEXP e;
	    PROTECT(e = allocVector(LANGSXP, 2));
	    nprotect++;
	    SETCAR(e, r_stringFun);
	    r_stringFun = e;
	}
	str_fun_type = INTEGER(r_str_type)[0];
    } else 
	r_stringFun = NULL;

    node = json_parse(str);
    ans = processJSONNode(node, json_type(node), INTEGER(simplify)[0], nullValue, LOGICAL(simplifyWithNames)[0],
 			  INTEGER(encoding)[0], r_stringFun, str_fun_type);
    json_delete(node);
    if(nprotect)
	UNPROTECT(nprotect);

    return(ans);
}

SEXP 
processJSONNode(JSONNODE *n, int parentType, int simplify, SEXP nullValue, int simplifyWithNames, cetype_t charEncoding,
                 SEXP r_stringCall, StringFunctionType str_fun_type)
{
    
    if (n == NULL){
        PROBLEM "invalid JSON input"
	    ERROR;
    }
 
    JSONNODE *i;
    int len = 0, ctr = 0;
    int nprotect = 0;
    int numNulls = 0;
    len = json_size(n);
    char startType = parentType; // was 127
    
    int isNullHomogeneous = (TYPEOF(nullValue) == LGLSXP || TYPEOF(nullValue) == REALSXP ||
                                TYPEOF(nullValue) == STRSXP || TYPEOF(nullValue) == INTSXP);
    int numStrings = 0;
    int numLogicals = 0;
    int numNumbers = 0;

    SEXP ans, names = NULL;
    PROTECT(ans = NEW_LIST(len)); nprotect++;

    int homogeneous = 0;
    int elType = NILSXP;
    while (ctr < len){  // i != json_end(n)

	i = json_at(n, ctr);

        if (i == NULL){
            PROBLEM "Invalid JSON Node"
		ERROR;
        }

	json_char *node_name = json_name(i);
	
	char type = json_type(i);
	if(startType == 127)
	    startType = type;

	SEXP el;
	switch(type) {
   	   case JSON_NULL:
	       el = nullValue; /* R_NilValue; */
	       numNulls++;
	       if(isNullHomogeneous) {
		   homogeneous++;
		   elType = setType(elType, TYPEOF(nullValue));
	       } else
		   elType = TYPEOF(nullValue);
	       break;
   	   case JSON_ARRAY:
  	   case JSON_NODE:
	       el = processJSONNode(i, type, simplify, nullValue, simplifyWithNames, charEncoding, r_stringCall, str_fun_type);
	       if(Rf_length(el) > 1)
		   elType = VECSXP;
	       else
		   elType = setType(elType, TYPEOF(el));
	       break;
 	   case JSON_NUMBER:
	       el = ScalarReal(json_as_float(i));
	       homogeneous++;
	       elType = setType(elType, REALSXP);
	       numNumbers++;
	       break;
 	   case JSON_BOOL:
	       el = ScalarLogical(json_as_bool(i));
	       elType = setType(elType, LGLSXP);
	       numLogicals++;
	       break;
 	   case JSON_STRING:
	   {
//XXX Garbage collection
#if 0 //def JSON_UNICODE
	       wchar_t *wtmp = json_as_string(i);
	       char *tmp;
	       int len = wcslen(wtmp);
	       int size = sizeof(char) * (len * MB_LEN_MAX + 1);
	       tmp = (char *)malloc(size);
	       if (tmp == NULL) {
                   PROBLEM "Cannot allocate memory"
                   ERROR;
               }
	       wcstombs(tmp, wtmp, size);
#else
    char *tmp = json_as_string(i);
//    tmp = reEnc(tmp, CE_BYTES, CE_UTF8, 1);
#endif


    if(r_stringCall != NULL && TYPEOF(r_stringCall) == EXTPTRSXP) {
        if(str_fun_type == SEXP_STR_ROUTINE) {
	    SEXPStringRoutine fun;
	    fun = (SEXPStringRoutine) R_ExternalPtrAddr(r_stringCall);	    
	    el = fun(tmp, charEncoding);
	} else {
	    char *tmp1;
	    StringRoutine fun;
	    fun = (StringRoutine) R_ExternalPtrAddr(r_stringCall);
	    tmp1 = fun(tmp);
	    if(tmp1 != tmp)
		json_free(tmp);
	    tmp = tmp1;
	    el = ScalarString(mkCharCE(tmp, charEncoding));
	}
    } else {
	el = ScalarString(mkCharCE(tmp, charEncoding));
    	     /* Call the R function if there is one. */
	if(r_stringCall != NULL) {
	    SETCAR(CDR(r_stringCall), el);
	    el = Rf_eval(r_stringCall, R_GlobalEnv);
	}
	/* XXX compute with elType. */
    }

	       json_free(tmp);
	       
	       elType = setType(elType, 
   				     /* If we have a class, not a primitive type */
                                  Rf_length(getAttrib(el, Rf_install("class"))) ? LISTSXP : TYPEOF(el));
               if(r_stringCall != NULL && str_fun_type != NATIVE_STR_ROUTINE) {
		   switch(TYPEOF(el)) {
			  case REALSXP:
   			     numNumbers++;
			  break;
			  case LGLSXP:
   			     numLogicals++;
			  break;
			  case STRSXP:
   			     numStrings++;
			  break;
		   }
	       } else if(TYPEOF(el) == STRSXP) 
		   numStrings++;
      }
	       break;
	default:
	    PROBLEM "shouldn't be here"
		WARN;
	    el = R_NilValue;
	    break;
	}
	SET_VECTOR_ELT(ans, ctr, el);

	if(parentType == JSON_NODE || (node_name && node_name[0])) {
	    if(names == NULL) {
	        PROTECT(names = NEW_CHARACTER(len)); nprotect++;
	    }
	    if(node_name && node_name[0])
		SET_STRING_ELT(names, ctr, mkChar(node_name));
	}
	json_free(node_name);
	ctr++;
    }

    /* If we have an empty object, we try to make it into a form equivalent to emptyNamedList
       if it is a {},  or as an AsIs object in R if an empty array. */
    if(len == 0 && (parentType == -1 || parentType == JSON_ARRAY || parentType == JSON_NODE)) {
        if(parentType == -1) 
            parentType = startType;

        if(parentType == JSON_NODE)
	   SET_NAMES(ans, NEW_CHARACTER(0));
        else  {
	   SET_CLASS(ans, ScalarString(mkChar("AsIs")));
	}

    } else if(simplifyWithNames || names == NULL || Rf_length(names) == 0) {
	int allSame = (numNumbers == len || numStrings == len || numLogicals == len) || 
	    ((TYPEOF(nullValue) == LGLSXP && LOGICAL(nullValue)[0] == NA_INTEGER) && 
	     ((numNumbers + numNulls) == len || (numStrings + numNulls) == len || (numLogicals + numNulls) == len));
        homogeneous = allSame ||  ( (numNumbers + numStrings + numLogicals + numNulls) == len);
        if(simplify == NONE) {
	} else if(allSame && 
 		   (numNumbers == len && (simplify & STRICT_NUMERIC)) ||
  		      ((numLogicals == len) && (simplify & STRICT_LOGICAL)) ||
		      ( (numStrings == len) && (simplify & STRICT_CHARACTER))) {
   	       ans = makeVector(ans, len, elType, nullValue);
	} else if((simplify == ALL && homogeneous) || (simplify == STRICT && allSame)) {
   	       ans = makeVector(ans, len, elType, nullValue);
	}
    }
      

    if(names)
	SET_NAMES(ans, names);
	
    UNPROTECT(nprotect);
    return(ans);
}

SEXP
makeVector(SEXP ans, int len, int type, SEXP nullValue)
{
    SEXP tmp;
    int ctr;

    if(type == REALSXP) {
	PROTECT(tmp = NEW_NUMERIC(len)); 
	for(ctr = 0; ctr < len; ctr++) {
	    SEXP el = VECTOR_ELT(ans, ctr);
	    REAL(tmp)[ctr] = TYPEOF(el) == LGLSXP && LOGICAL(el)[0] == NA_INTEGER ? NA_REAL : (TYPEOF(el) == REALSXP ? REAL(el)[0] : Rf_asReal(el));
	}
    } else if(type == LGLSXP) {
	PROTECT(tmp = NEW_LOGICAL(len)); 
	for(ctr = 0; ctr < len; ctr++) {
	    SEXP el = VECTOR_ELT(ans, ctr);
	    LOGICAL(tmp)[ctr] = TYPEOF(el) == LGLSXP ? LOGICAL(el)[0] : Rf_asInteger(el);
	}
    } else if(type == STRSXP) {
	PROTECT(tmp = NEW_CHARACTER(len)); 
	for(ctr = 0; ctr < len; ctr++) {
	    SEXP el = VECTOR_ELT(ans, ctr);
	    if(TYPEOF(el) == STRSXP)
		SET_STRING_ELT(tmp, ctr, STRING_ELT(el, 0));
	    else if(TYPEOF(el) == LGLSXP) {
		SET_STRING_ELT(tmp, ctr, LOGICAL(el)[0] == NA_INTEGER ? NA_STRING : mkChar(LOGICAL(el)[0] ? "TRUE" : "FALSE"));
	    } else if(TYPEOF(el) == REALSXP) {
		char buf[70];
		sprintf(buf, "%lf", REAL(el)[0]);
		SET_STRING_ELT(tmp, ctr, mkChar(buf));
	    }
	}
    } else
	return(ans);

    UNPROTECT(1);
    return(tmp);
}

int setType(int cur, int newType)
{
    if(cur == newType)
	return(cur);

    if(newType == VECSXP || cur == VECSXP)
	return(VECSXP);

    switch(cur) {
    case INTSXP:
	switch(newType) {
	case LGLSXP:
	    return(INTSXP);
	    break;
	case REALSXP:
	    return(REALSXP);
	    break;
	case STRSXP:
	    return(STRSXP);
	    break;
	}
	break;
    case LGLSXP:
	switch(newType) {
	case INTSXP:
	    return(INTSXP);
	    break;
	case REALSXP:
	    return(REALSXP);
	    break;
	case STRSXP:
	    return(STRSXP);
	    break;
	}
	break;
    case REALSXP:
	switch(newType) {
	case INTSXP:
	    return(REALSXP);
	    break;
	case LGLSXP:
	    return(REALSXP);
	    break;
	case STRSXP:
	    return(STRSXP);
	    break;
	}
	break;
    case STRSXP:
	return(STRSXP);
	break;
    }

    return(newType);
}



SEXP
R_libjson_version()
{
    char buf[20];
    sprintf(buf, "%d.%d-%d", (int) __LIBJSON_MAJOR__,
    	                     (int) __LIBJSON_MINOR__,
	                     (int) __LIBJSON_PATCH__);

    return(ScalarString(mkChar(buf)));
}


SEXP
R_isValidJSON(SEXP input)
{
    const char *txt;
    int status = 0;
    txt = CHAR(STRING_ELT(input, 0));
    status = json_is_valid(txt);
    return(ScalarLogical(status));
}






/******************/

#if 0

SEXP
R_json_new_stream(SEXP fun, SEXP pullFun)
{
    JSONSTREAM *stream;
    stream = json_new_stream();
}

SEXP
R_json_stream_push(SEXP r_stream, SEXP r_txt)
{
    JSONSTREAM *stream;
    stream = R_getStreamRef(r_stream);

    json_stream_push(stream, CHAR(STRING_ELT(r_txt, 0)));
    return(ScalarLogical(1));
}
#endif


#ifndef NEW_JSON_NEW_STREAM
SEXP expr;
#endif

SEXP
R_json_node_type(SEXP r_ref)
{
    JSONNODE *node = (JSONNODE *) R_ExternalPtrAddr(r_ref);
    return(ScalarInteger( (int) json_type(node)));
}

void
#ifdef NEW_JSON_NEW_STREAM
R_stream_callback(JSONNODE *node, void *data)
#else
R_stream_callback(JSONNODE *node) 
#endif
{
#ifdef NEW_JSON_NEW_STREAM
    SEXP expr = (SEXP) data;
#endif
    SEXP ref;
    ref = CAR(CDR(expr));
    R_SetExternalPtrAddr(ref, node);
    Rf_eval(expr, R_GlobalEnv);
}


SEXP 
makeNodeRef(JSONNODE *node)
{
    SEXP ans;
    PROTECT(ans = R_MakeExternalPtr(node, Rf_install("JSONNODE"), R_NilValue));
    SET_CLASS(ans, ScalarString(mkChar("JSONNODE")));
    UNPROTECT(1);
    return(ans);

}



SEXP
R_json_stream_parse(SEXP str, SEXP fun)
{
    JSONSTREAM *stream;
    SEXP nodeRef;
#ifdef NEW_JSON_NEW_STREAM 
    SEXP expr;
#endif    

    PROTECT(expr = allocVector(LANGSXP, 2));
    SETCAR(expr, fun);
    nodeRef = makeNodeRef(NULL);
    SETCAR(CDR(expr), nodeRef);

#ifdef NEW_JSON_NEW_STREAM 
    stream = json_new_stream(R_stream_callback, NULL, expr);
#else
    stream = json_new_stream(R_stream_callback);
#endif

    json_stream_push(stream, CHAR(STRING_ELT(str, 0)));
    UNPROTECT(1);
    return(R_NilValue);
}


SEXP
R_jsonPrettyPrint(SEXP r_content, SEXP r_encoding)
{
    const char *str = CHAR(STRING_ELT(r_content, 0));
    JSONNODE *node;
    json_char *ans;
    
    node = json_parse(str);
    if(!node) {
	PROBLEM "couldn't parse the JSON content"
	    ERROR;
    }

    ans = json_write_formatted(node);
    return(ScalarString(mkCharCE(ans, INTEGER(r_encoding)[0])));
}


const char *
dummyStringOperation(const char *value)
{
#ifdef TEST_DUMMY_STRING_OP
    fprintf(stderr, "[dummyStringOperation] %s\n", value);
#endif
    return(value);
}

SEXP
R_json_dateStringOp(const char *value, cetype_t encoding)
{
    int withNew = 0, noNew = 0;

    if( (noNew = (strncmp(value, "/Date(", 6)  == 0)) ||
          (withNew = strncmp(value, "/new Date(", 10)) == 0) {
        double num;
	if(noNew) 
   	   sscanf(value + 6, "%lf)/", &num);
	else
   	   sscanf(value + 10, "%lf)/", &num);

	SEXP ans, classNames;
        PROTECT(ans = ScalarReal(num));
	PROTECT(classNames = NEW_CHARACTER(2));
	SET_STRING_ELT(classNames, 0, mkChar("POSIXct"));
	SET_STRING_ELT(classNames, 1, mkChar("POSIXt"));
	SET_CLASS(ans, classNames);
        UNPROTECT(2);
	return(ans);
    } else
       return(ScalarString(mkCharCE(value, encoding)));
}
