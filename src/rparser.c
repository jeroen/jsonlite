#include "Rlibjson.h"
#if 0
#include <libjson/libjson.h>
//#include <Source/JSONStream.h>

#include <Rdefines.h>
#include <Rinternals.h>
#endif


typedef struct {
    int cumBytes;
    SEXP call;
    JSONSTREAM *stream;
} RCallback;


static FILE *out = NULL;

void
errorCB(void *ptr)
{
    RCallback *data = (RCallback *) ptr;
    int num = 0;
    if(data)
	num = data->cumBytes;

//    if(data->stream)
//       json_delete_stream(data->stream);
    if(out) {
	fclose(out); out = NULL;
    }

    PROBLEM "failed to parse json at %d",  num
	ERROR;
}


SEXP
R_makeJSONRef(JSONNODE *node)
{
    return(processJSONNode(node, json_type(node), 1, R_NilValue, 1, CE_NATIVE, NULL, GARBAGE));
    
//    return(R_NilValue);
}

void
R_json_parser_callback(JSONNODE *node, void *userdata)
{
    SEXP ans;
    RCallback *data = (RCallback*)userdata;
fprintf(stderr, "callback\n");

//    SETCAR( CDR(e), ScalarInteger(json_type(node)));
    ans = R_makeJSONRef(node);
    SETCAR( CDR(data->call), ans);

    ans = Rf_eval(data->call, R_GlobalEnv);
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
	if(!out) 
            out = fopen("/tmp/check.json", "w");

#if 0
fprintf(stderr, "# %d to %d\n   '%s'", (int) strlen(ptr), *numBytes, ptr);
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


SEXP
R_json_parser_init_from_con(SEXP conCall, SEXP cbCall)
{
    JSONSTREAM *stream;
    RCallback cb;
    SEXP e;

    stream = json_new_stream(R_json_parser_callback, errorCB, &cb);
    if(!stream) {
	PROBLEM "Couldn't create json stream"
	    ERROR;
    }

    cb.stream = stream;
//    cb.call = cbCall;
    cb.cumBytes = 0;

    PROTECT(e = allocVector(LANGSXP, 1));
    SETCAR(e, conCall);
    cb.call = e ;

    while(getData(e, stream, &(cb.cumBytes))) {  }

//    json_delete_stream(stream);
    UNPROTECT(1);
    if(out) {
	fclose(out); out = NULL;
    }

    return(ScalarLogical(TRUE));
}


#if 1

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

    fprintf(stderr, "Read (%d) %d/%d bytes\n'%s'\n", (int) strlen(buffer), (int) num, total, buffer);
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
fprintf(stderr, "%d) %s\n", count++, tmp);
        json_stream_push(stream, strdup(tmp));
	cur += blocksize;
    }



    R_ReleaseObject(top);
    return(top);
//    return(R_NilValue);
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
