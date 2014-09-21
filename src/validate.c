#include <Rinternals.h>
#include <string.h>
#include <yajl_parse.h>

SEXP R_validate(SEXP x) {
    yajl_status stat;
    yajl_handle hand;

    /* parser options */
    //yajl_config(hand, yajl_allow_comments, 1);

    /* get data from R */
    const char* json = translateCharUTF8(asChar(x));
    const size_t rd = strlen(json);

    /* allocate a parser */
    hand = yajl_alloc(NULL, NULL, NULL);
    stat = yajl_parse(hand, (const unsigned char*) json, rd);
    stat = yajl_complete_parse(hand);

    SEXP output = ScalarLogical(!stat);

    //error message
    if (stat != yajl_status_ok) {
        unsigned char* str = yajl_get_error(hand, 1, (const unsigned char*) json, rd);
        SEXP errstr = mkString((const char *) str);
        yajl_free_error(hand, str);
        setAttrib(output, install("err"), errstr);
    }

    /* return boolean vec (0 means no errors, means is valid) */
    yajl_free(hand);
    return output;
}
