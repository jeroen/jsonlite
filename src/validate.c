#include <Rinternals.h>
#include <string.h>
#include <yajl_parse.h>

SEXP R_validate(SEXP x) {
    yajl_status stat;
    yajl_handle hand;

    /* get data from R */
    const char* json = translateCharUTF8(asChar(x));
    const size_t rd = strlen(json);

    /* allocate a parser */
    hand = yajl_alloc(NULL, NULL, NULL);

    /* parser options */
    //yajl_config(hand, yajl_dont_validate_strings, 1);

    /* go parse */
    stat = yajl_parse(hand, (const unsigned char*) json, rd);
    if(stat == yajl_status_ok) {
      stat = yajl_complete_parse(hand);
    }

    SEXP output = PROTECT(duplicate(ScalarLogical(!stat)));

    //error message
    if (stat != yajl_status_ok) {
        unsigned char* str = yajl_get_error(hand, 1, (const unsigned char*) json, rd);
        SEXP errstr = mkString((const char *) str);
        yajl_free_error(hand, str);
        setAttrib(output, install("err"), errstr);
    }

    /* return boolean vec (0 means no errors, means is valid) */
    yajl_free(hand);
    UNPROTECT(1);
    return output;
}
