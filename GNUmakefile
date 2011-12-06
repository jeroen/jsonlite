include $(OMEGA_HOME)/R/Config/GNUmakefile

build: Changes.html Changes
	-rm src/*.o src/*.so
	(cd .. ; R CMD build RJSONIO)

XSL_DIR=$(OMEGA_HOME)/Docs/XSL
Changes.html: Changes.xml
	xsltproc -o $@ $(XSL_DIR)/html/ChangeLog.xsl $< 

Changes: Changes.xml
	xsltproc -o $@ $(XSL_DIR)/text/ChangeLog.xsl $< 
