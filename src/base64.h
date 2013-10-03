#ifndef BASE64__BASE64_H
#define BASE64__BASE64_H

#include <R.h> 
#include <Rinternals.h> 

#include <stdio.h>
#include <stdlib.h>

/*
** returnable errors
**
** Error codes returned to the operating system.
**
*/
#define B64_SYNTAX_ERROR        1
#define B64_FILE_ERROR          2
#define B64_FILE_IO_ERROR       3
#define B64_ERROR_OUT_CLOSE     4
#define B64_LINE_SIZE_TO_MIN    5

#define B64_DEF_LINE_SIZE   72                                                         
#define B64_MIN_LINE_SIZE    4

#define THIS_OPT(ac, av) (ac > 1 ? av[1][0] == '-' ? av[1][1] : 0 : 0)

#define B64_MAX_MESSAGES 6

SEXP base64_encode_(SEXP input, SEXP output, SEXP line_size) ;
SEXP base64_decode_(SEXP input, SEXP output) ;


#endif                                                                         
