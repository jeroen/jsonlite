Changes in yajl code by Jeroen:

 - Manually changed the header include paths in some c/h files to avoid cmake dependency.
 - Comment out call to abort() in src/yajl/yajl_parser.c (for CMD check)
 - Manually generated yajl.version.h from yajl.version.h.in (by running cmake)
 - Patch for CMD check warnings on Windows: https://github.com/lloyd/yajl/issues/143
