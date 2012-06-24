#include "Rlibjson.h"

typedef struct {
    int cumBytes;
    SEXP call;
    JSONSTREAM *stream;
    SEXP result;

    int simplify;
    int simplifyWithNames;
    SEXP nullValue;

    FILE *file;
} RCallback;

//#define R_DEBUG_STREAM 1
//#define CHECK_CONTENT 1
#ifdef CHECK_CONTENT
static FILE *out = NULL;
#endif

void
errorCB(void *ptr)
{
    RCallback *data = (RCallback *) ptr;
    int num = 0;
    if(data)
	num = data->cumBytes;

    if(data->file)
	fclose(data->file);

//    if(data->stream)
//       json_delete_stream(data->stream);
#ifdef CHECK_CONTENT
    if(out) {
	fclose(out); out = NULL;
    }
#endif

    PROBLEM "failed to parse json at %d",  num
	ERROR;
}


SEXP
R_makeJSONRef(JSONNODE *node)
{
  return(processJSONNode(node, json_type(node), 1, R_NilValue, 1, CE_NATIVE, NULL, GARBAGE));
}

void
R_json_parser_callback(JSONNODE *node, void *userdata)
{
    SEXP ans;
    RCallback *data = (RCallback*)userdata;

    SEXP tmp;


    tmp = processJSONNode(node, json_type(node), data->simplify, data->nullValue, data->simplifyWithNames, 
			  CE_NATIVE, NULL, GARBAGE);

    if(data->call == R_NilValue) {
        ans = tmp;
    } else {
//    SETCAR( CDR(e), ScalarInteger(json_type(node)));
       PROTECT(tmp);
       PROTECT(ans = R_makeJSONRef(node));
       SETCAR( CDR(data->call), ans);

       ans = Rf_eval(data->call, R_GlobalEnv);
       UNPROTECT(2);
    }
    data->result = ans;
    R_PreserveObject(data->result);
}



static int
getData(SEXP call, JSONSTREAM *stream, int *numBytes)
{
    SEXP r_str;
    int num;

//fprintf(stderr, "getData\n");

    PROTECT(r_str = Rf_eval(call, R_GlobalEnv));
    if( (num = Rf_length(r_str)) ) {
	const char *ptr = CHAR(STRING_ELT(r_str, 0));
	int len = strlen(ptr);

	*numBytes += len;
        ptr = strdup(ptr); //xxx
#ifdef CHECK_CONTENT
	if(!out) 
            out = fopen("/tmp/check.json", "w");
#endif


#if R_DEBUG_STREAM
fprintf(stderr, "# %d to %d\n   '%s'", (int) strlen(ptr), *numBytes, ptr);
#endif
#ifdef CHECK_CONTENT
fprintf(out, "%s", ptr);
#endif
	json_stream_push(stream, ptr);
    } else {
#if 0
       fprintf(stderr, "finished reading data with %d bytes\n", *numBytes);
#endif
    }
    UNPROTECT(1);
    
    return(num > 0);
}


int
readFileData(FILE *f, JSONSTREAM *stream, int *numBytes)
{
    char buffer[1024];
    size_t num;
    int len = sizeof(buffer)/sizeof(buffer[0]) - 1;
    num = fread(buffer, 1,  len - 2, f);
    *numBytes += num;
    buffer[num] = '\0';

    json_stream_push(stream, strdup(buffer));
#ifdef R_DEBUG_STREAM
    fprintf(stderr, "Read (%d) %d/%d bytes\n'%s'\n", (int) strlen(buffer), (int) num, *numBytes, buffer);
#endif
    return(num == len - 2);
}


typedef void (*ParserCallback)(JSONNODE *, void *);

SEXP
R_json_parser_init_from_con(SEXP conCall, SEXP cbCall,
			    SEXP simplify,  SEXP nullValue, SEXP simplifyWithNames)
{
    JSONSTREAM *stream;
    RCallback cb;
    int nprotect = 0;
    ParserCallback callback;

    if(TYPEOF(cbCall) == EXTPTRSXP)
        callback = R_ExternalPtrAddr(cbCall);
    else
	callback = R_json_parser_callback;

    stream = json_new_stream(callback, errorCB, &cb);
    if(!stream) {
	PROBLEM "Couldn't create json stream"
	    ERROR;
    }

    cb.stream = stream;
    cb.cumBytes = 0;
    cb.result = NULL;
    cb.simplify = INTEGER(simplify)[0];
    cb.simplifyWithNames = INTEGER(simplifyWithNames)[0];
    cb.nullValue = nullValue;
    cb.file = NULL;

    if(TYPEOF(cbCall) == CLOSXP) {
	PROTECT(cb.call = allocVector(LANGSXP, 2));
	SETCAR(cb.call, cbCall);
	nprotect++;
    } else
      cb.call =  cbCall;

    if(TYPEOF(conCall) == STRSXP) {
	FILE *f;
	f = fopen(CHAR(STRING_ELT(conCall, 0)), "r");
	if(!f) {
	    json_delete_stream(stream);
	    PROBLEM "cannot open JSON file %s", CHAR(STRING_ELT(conCall, 0))
		ERROR;
	}
	cb.file = f;
	    
	while(readFileData(f, stream, &(cb.cumBytes))) {  }
	fclose(f);
    } else {
	while(getData(conCall, stream, &(cb.cumBytes))) {  }
    }

    if(nprotect)
	UNPROTECT(nprotect);

#ifdef CHECK_CONTENT
    if(out) {
	fclose(out); out = NULL;
    }
#endif


    json_delete_stream(stream);

    return(cb.result ? cb.result : R_NilValue);
}




#if 0

SEXP top = NULL;

void
R_json_cb_test_stream(JSONNODE *node, void *userdata)
{
//    fprintf(stderr, "Finished parsing\n");
    top = processJSONNode(node, 0, 1, R_NilValue, 1, CE_NATIVE, NULL, GARBAGE);
    R_PreserveObject(top);
}

static int total = 0;
int
test_get_data(FILE *f, JSONSTREAM *stream)
{
    char buffer[1024];
    size_t num;
    int len = sizeof(buffer)/sizeof(buffer[0]) - 1;
    num = fread(buffer, 1,  len - 2, f);
    total += num;
    buffer[num] = '\0';

    json_stream_push(stream, strdup(buffer));
#ifdef R_DEBUG_STREAM
    fprintf(stderr, "Read (%d) %d/%d bytes\n'%s'\n", (int) strlen(buffer), (int) num, total, buffer);
#endif
    return(num == len - 2);
}

SEXP
R_json_parser_test_stream(SEXP r_filename)
{
    JSONSTREAM *stream;
    FILE *fileptr;

    fileptr = fopen(CHAR(STRING_ELT(r_filename, 0)), "r");
    if(!fileptr) {
	PROBLEM "cannot open file"
	    ERROR;
    }

    stream = json_new_stream(R_json_cb_test_stream, errorCB, NULL);
    if(!stream) {
	PROBLEM "Couldn't create json stream"
	    ERROR;
    }

    json_stream_push(stream, "{ \"a\": [1, 2, 3]}[true, false]");

    while(test_get_data(fileptr, stream)) {   }
    json_stream_push(stream, "");

    fclose(fileptr);
    json_delete_stream(stream);

    return(R_NilValue);
}


SEXP
R_json_parser_test_stream_str(SEXP r_filename)
{
    JSONSTREAM *stream;
    const char *str = CHAR(STRING_ELT(r_filename, 0));

    stream = json_new_stream(R_json_cb_test_stream, errorCB, NULL);
    if(!stream) {
	PROBLEM "Couldn't create json stream"
	    ERROR;
    }

    json_stream_push(stream, str);

    R_ReleaseObject(top);
    return(top);
//    return(R_NilValue);
}


SEXP
R_json_parser_test_stream_chunk(SEXP r_filename)
{
    JSONSTREAM *stream;
    const char *str = CHAR(STRING_ELT(r_filename, 0));

    stream = json_new_stream(R_json_cb_test_stream, errorCB, NULL);
    if(!stream) {
	PROBLEM "Couldn't create json stream"
	    ERROR;
    }
    
    int len = strlen(str), cur = 0, blocksize = 100;
    int count = 0;
    char tmp[blocksize + 1];
    tmp[blocksize] = '\0';
    while(cur < len) {
	strncpy(tmp, str + cur, blocksize);
#ifdef R_DEBUG_STREAM
fprintf(stderr, "%d) %s\n", count++, tmp);
#endif
        json_stream_push(stream, strdup(tmp));
	cur += blocksize;
    }

    R_ReleaseObject(top);
    return(top);
}



SEXP
R_json_parser_test_stream_chunk_con(SEXP r_getData)
{
    JSONSTREAM *stream;

    stream = json_new_stream(R_json_cb_test_stream, errorCB, NULL);
    if(!stream) {
	PROBLEM "Couldn't create json stream"
	    ERROR;
    }
    
    int n = 0;
    while(getData(r_getData, stream, &n)) {}

    R_ReleaseObject(top);
    return(top);
}


#endif
