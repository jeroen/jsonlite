#include <Rinternals.h>
#include <yajl_tree.h>
#include <yajl_parse.h>
#include <push_parser.h>

/* finalizer */
yajl_handle push_parser;

SEXP R_reset_push_parser() {
  /* init new push parser */
  if(push_parser)
    yajl_free(push_parser);

  push_parser = push_parser_new();
  return ScalarLogical(1);
}

SEXP R_feed_push_parser(SEXP x){
  /* check for errors */
  if (yajl_parse(push_parser, RAW(x), length(x)) != yajl_status_ok) {
    unsigned char* errstr = yajl_get_error(push_parser, 1, RAW(x), length(x));
    SEXP tmp = mkChar((const char*) errstr);
    yajl_free_error(push_parser, errstr);
    error(CHAR(tmp));
  }

  /* return OK */
  return ScalarLogical(1);
}

SEXP R_finalize_push_parser(SEXP bigint_as_char){
  /* check for errors */
  if (yajl_complete_parse(push_parser) != yajl_status_ok) {
    unsigned char* errstr = yajl_get_error(push_parser, 1, NULL, 0);
    SEXP tmp = mkChar((const char*) errstr);
    yajl_free_error(push_parser, errstr);
    error(CHAR(tmp));
  }

  /* get value */
  yajl_val tree = push_parser_get(push_parser);
  SEXP out = ParseValue(tree, asLogical(bigint_as_char));
  yajl_tree_free(tree);
  return out;
}
