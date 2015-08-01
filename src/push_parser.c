#include <Rinternals.h>
#include <yajl_tree.h>
#include <yajl_parse.h>
#include <push_parser.h>

/* finalizer */
yajl_handle push_parser;

void reset_parser(){
  if(push_parser != NULL){
    yajl_free(push_parser);
    push_parser = NULL;
  }
}

SEXP R_feed_push_parser(SEXP x, SEXP reset){

  /* raw pointer */
  const unsigned char *json = RAW(x);
  int len = LENGTH(x);

  /* init new push parser */
  if(asLogical(reset)) {
    reset_parser();
    push_parser = push_parser_new();

    /* ignore BOM as suggested by RFC */
    if(len > 3 && json[0] == 239 && json[1] == 187 && json[2] == 191){
      warningcall(R_NilValue, "JSON string contains (illegal) UTF8 byte-order-mark!");
      json += 3;
      len -= 3;
    }
  }

  /* check for errors */
  if (yajl_parse(push_parser, json, len) != yajl_status_ok) {
    unsigned char* errstr = yajl_get_error(push_parser, 1, RAW(x), length(x));
    SEXP tmp = mkChar((const char*) errstr);
    yajl_free_error(push_parser, errstr);
    reset_parser();
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
    reset_parser();
    error(CHAR(tmp));
  }

  /* get value */
  yajl_val tree = push_parser_get(push_parser);
  SEXP out = ParseValue(tree, asLogical(bigint_as_char));
  yajl_tree_free(tree);
  reset_parser();
  return out;
}
