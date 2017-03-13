#include <Rinternals.h>
#include <Rversion.h>
#include <R_ext/Connections.h>
#include <string.h>
#include <yajl_tree.h>
#include <yajl_parse.h>
#include "push_parser.h"

#if R_CONNECTIONS_VERSION != 1
#error "Missing or unsupported connection API in R"
#endif

Rconnection get_connection(SEXP con) {
#if defined(R_VERSION) && R_VERSION >= R_Version(3, 3, 0)
  return R_GetConnection(con);
# else
  extern Rconnection getConnection(int) ;
  if (!Rf_inherits(con, "connection"))
    Rf_error("invalid connection");
  return getConnection(Rf_asInteger(con));
#endif
}

#define bufsize 1024
SEXP R_parse_connection(SEXP sConn, SEXP bigint_as_char){
  Rconnection con = get_connection(sConn);
  int first = 1;
  char errbuf[bufsize];
  unsigned char buf[bufsize];
  unsigned char * ptr = buf;
  unsigned char * errstr;
  yajl_handle push_parser = push_parser_new();
  while(1){
    R_CheckUserInterrupt();
    int len = R_ReadConnection(con, ptr, bufsize);
    if(len <= 0)
      break;

    //strip off BOM
    if(first && len > 3 && ptr[0] == 239 && ptr[1] == 187 && ptr[2] == 191){
      warningcall(R_NilValue, "JSON string contains (illegal) UTF8 byte-order-mark!");
      ptr += 3;
      len -= 3;
    }

    //strip off rfc7464 record separator
    if(first && len > 1 && ptr[0] == 30){
      ptr += 1;
      len -= 1;
    }

    first = 0;

    /* parse and check for errors */
    if (yajl_parse(push_parser, ptr, len) != yajl_status_ok){
      errstr = yajl_get_error(push_parser, 1, ptr, len);
      goto JSON_FAIL;
    }
  }

  /* complete parse */
  if (yajl_complete_parse(push_parser) != yajl_status_ok){
    errstr = yajl_get_error(push_parser, 1, NULL, 0);
    goto JSON_FAIL;
  }

  /* get output */
  yajl_val tree = push_parser_get(push_parser);
  SEXP out = ParseValue(tree, asLogical(bigint_as_char));
  yajl_tree_free(tree);
  yajl_free(push_parser);
  return out;

  JSON_FAIL:
    strncpy(errbuf, (char *) errstr, bufsize);
    yajl_free_error(push_parser, errstr);
    yajl_free(push_parser);
    Rf_error(errbuf);
}
