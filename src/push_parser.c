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

#if defined(R_VERSION) && R_VERSION < R_Version(3, 3, 0)
Rconnection R_GetConnection(SEXP sConn);
#endif

#define bufsize 1024
SEXP R_parse_connection(SEXP sConn, SEXP bigint_as_char){
  Rconnection con = R_GetConnection(sConn);
  char errbuf[bufsize];
  unsigned char buf[bufsize];
  unsigned char * errstr;
  yajl_handle push_parser = push_parser_new();
  int len;
  while(1){
    R_CheckUserInterrupt();
    len = R_ReadConnection(con, buf, bufsize);
    if(len <= 0)
      break;

    /* parse and check for errors */
    if (yajl_parse(push_parser, buf, len) != yajl_status_ok){
      errstr = yajl_get_error(push_parser, 1, buf, len);
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
