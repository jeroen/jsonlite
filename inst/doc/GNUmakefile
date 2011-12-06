ifndef DYN_DOCS
 DYN_DOCS=$(HOME)/Classes/StatComputing/XDynDocs/inst
endif

TEX_XSL_ARGS=--stringparam doc.class '[article]{jss}' --stringparam bibliog.file $*
DB2JSS_XSL=$(DYN_DOCS)/XSL/OmegahatXSL/latex/myRawJSS.xsl
LATEX_STYLE=$(DB2JSS_XSL)

overview.tex: overview.bib

include $(DYN_DOCS)/Make/Makefile
